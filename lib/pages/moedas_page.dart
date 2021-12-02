import 'package:flutter/material.dart';
import 'package:flutter_aula1/models/moeda.dart';
import 'package:flutter_aula1/pages/moedas_detalhes_page.dart';
import 'package:flutter_aula1/repositories/moeda_repository.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  _MoedasPageState createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Moeda> selecionadas = [];

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Container(
            alignment: Alignment.center, child: const Text('Cripto Moedas')),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Container(
            alignment: Alignment.center,
            child: Text('${selecionadas.length} selecionadas')),
        backgroundColor: Colors.blueGrey[400],
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
        toolbarTextStyle: const TextStyle(color: Colors.black87),
      );
    }
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MoedasDetalhes(moeda: moeda),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            selecionadas.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        for (var moeda in selecionadas) {
                          tabela.remove(moeda);
                        }
                        selecionadas = [];
                      });
                    },
                  )
                : Container(),
            // TextButton(
            //   child: const Text('Limpar'),
            //   onPressed: () {
            //     setState(() {
            //       selecionadas = [];
            //     });
            //   },
            // ),
            // TextButton(
            //   child: const Text('Salvar'),
            //   onPressed: () {
            //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //       content: Text('Moeda salva com sucesso'),
            //       duration: Duration(seconds: 2),
            //     ));
            //   },
            // ),
          ],
        ),
      ),
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          var textStyle = const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          );
          var listTile = ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: (selecionadas.contains(tabela[moeda]))
                ? const CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    child: Image.asset(tabela[moeda].icone),
                    width: 40,
                  ),
            title: Text(
              tabela[moeda].nome,
              style: textStyle,
            ),
            trailing: Text(
              real.format(tabela[moeda].preco),
              style: const TextStyle(fontSize: 15),
            ),
            selected: selecionadas.contains(tabela[moeda]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[moeda]))
                    ? selecionadas.remove(tabela[moeda])
                    : selecionadas.add(tabela[moeda]);
              });
            },
            onTap: () => mostrarDetalhes(tabela[moeda]),
          );
          return listTile;
        },
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, ___) => const Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {},
              label: const Text(
                'Favoritar ',
                style: TextStyle(fontSize: 15, letterSpacing: 0),
              ),
              icon: const Icon(Icons.favorite),
              backgroundColor: Colors.blue[400],
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
