import 'package:flutter/material.dart';
import 'package:flutter_aula1/configs/app_settings.dart';
import 'package:flutter_aula1/models/produto.dart';
import 'package:flutter_aula1/pages/produtos_detalhes_page.dart';
import 'package:flutter_aula1/repositories/favoritas_repository.dart';
import 'package:flutter_aula1/repositories/produto_repository.dart';
import 'package:flutter_aula1/routes/app_routes.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProdutosPage extends StatefulWidget {
  ProdutosPage({Key? key}) : super(key: key);

  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  final tabela = ProdutoRepository.tabela;
  late NumberFormat real;
  late Map<String, String> loc;
  List<Produto> selecionadas = [];
  late FavoritasRepository favoritas;
  late ProdutoRepository produtos;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return IconButton(
      icon: Icon(Icons.add_circle),
      onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.PRODUTO_FORM, arguments: '');
      },
    );
  }

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text('Produtos Medidas'),
        actions: [
          changeLanguageButton(),
        ],
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            limparSelecionadas();
          },
        ),
        title: Text('${selecionadas.length} selecionadas'),
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  mostrarDetalhes(Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProdutosDetalhesPage(produto: produto),
      ),
    );
  }

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // produtos = Provider.of<ProdutoRepository>(context);
    favoritas = context.watch<FavoritasRepository>();

    readNumberFormat();

    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int produto) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: (selecionadas.contains(tabela[produto]))
                ? CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(tabela[produto].urlImage),
                    ),
                    width: 40,
                  ),
            title: Row(
              children: [
                Text(
                  tabela[produto].nome,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (favoritas.lista
                    .any((fav) => fav.descricao == tabela[produto].descricao))
                  Icon(Icons.circle, color: Colors.amber, size: 8),
              ],
            ),
            // trailing: Text(
            //   real.format(tabela[produto].preco),
            //   style: TextStyle(fontSize: 15),
            // ),
            selected: selecionadas.contains(tabela[produto]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[produto]))
                    ? selecionadas.remove(tabela[produto])
                    : selecionadas.add(tabela[produto]);
              });
            },
            onTap: () => mostrarDetalhes(tabela[produto]),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, ___) => Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favoritas.saveAll(selecionadas);
                limparSelecionadas();
              },
              icon: Icon(Icons.star),
              label: Text(
                'FAVORITAR',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
