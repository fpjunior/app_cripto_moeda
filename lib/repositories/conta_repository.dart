import 'package:flutter/material.dart';
import 'package:flutter_aula1/database/db.dart';
import 'package:flutter_aula1/models/historico.dart';
import 'package:flutter_aula1/models/produto.dart';
import 'package:flutter_aula1/models/posicao.dart';
import 'package:flutter_aula1/repositories/produto_repository.dart';
import 'package:sqflite/sqlite_api.dart';

class ContaRepository extends ChangeNotifier {
  late Database db;
  List<Posicao> _carteira = [];
  List<Historico> _historico = [];
  double _saldo = 0;

  get saldo => _saldo;
  List<Posicao> get carteira => _carteira;
  List<Historico> get historico => _historico;

  ContaRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getSaldo();
    // await _getCarteira();
    // await _getHistorico();
  }

  // _getHistorico() async {
  //   _historico = [];
  //   List operacoes = await db.query('historico');
  //   operacoes.forEach((operacao) {
  //     Produto produto = ProdutoRepository.tabela.firstWhere(
  //       (m) => m.descricao == operacao['descricao'],
  //     );
  //     _historico.add(Historico(
  //       dataOperacao:
  //           DateTime.fromMillisecondsSinceEpoch(operacao['data_operacao']),
  //       tipoOperacao: operacao['tipo_operacao'],
  //       produto: produto,
  //       valor: operacao['valor'],
  //       quantidade: double.parse(operacao['quantidade']),
  //     ));
  //   });
  //   notifyListeners();
  // }

  _getSaldo() async {
    db = await DB.instance.database;
    List conta = await db.query('conta', limit: 1);
    _saldo = conta.first['saldo'];
    notifyListeners();
  }

  setSaldo(double valor) async {
    db = await DB.instance.database;
    db.update('conta', {
      'saldo': valor,
    });
    _saldo = valor;
    notifyListeners();
  }

  _getCarteira() async {
    _carteira = [];
    List posicoes = await db.query('carteira');
    posicoes.forEach((posicao) {
      Produto produto = ProdutoRepository.tabela.firstWhere(
        (m) => m.descricao == posicao['descricao'],
      );
      _carteira.add(Posicao(
        produto: produto,
        quantidade: double.parse(posicao['quantidade']),
      ));
    });
    notifyListeners();
  }

  comprar(Produto produto, double valor) async {
    db = await DB.instance.database;

    await db.transaction((txn) async {
      // Verificar se a produto já foi comprada
      final posicaoMoeda = await txn.query(
        'carteira',
        where: 'descricao = ?',
        whereArgs: [produto.descricao],
      );
      // Se não tem a produto ainda, insert
      if (posicaoMoeda.isEmpty) {
        await txn.insert('carteira', {
          'descricao': produto.descricao,
          'produto': produto.nome,
          'quantidade': (valor / produto.preco).toString()
        });
      } else {
        final atual = double.parse(posicaoMoeda.first['quantidade'].toString());
        await txn.update(
          'carteira',
          {'quantidade': ((valor / produto.preco) + atual).toString()},
          where: 'descricao = ?',
          whereArgs: [produto.descricao],
        );
      }

      // Inserir o histórico
      await txn.insert('historico', {
        'descricao': produto.descricao,
        'produto': produto.nome,
        'quantidade': (valor / produto.preco).toString(),
        'valor': valor,
        'tipo_operacao': 'compra',
        'data_operacao': DateTime.now().millisecondsSinceEpoch
      });

      await txn.update('conta', {'saldo': saldo - valor});
    });

    await _initRepository();
    notifyListeners();
  }
}
