import 'produto.dart';

class Historico {
  DateTime dataOperacao;
  String tipoOperacao;
  Produto produto;
  double valor;
  double quantidade;

  Historico({
    required this.dataOperacao,
    required this.tipoOperacao,
    required this.produto,
    required this.valor,
    required this.quantidade,
  });
}
