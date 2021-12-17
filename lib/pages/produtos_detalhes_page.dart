import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aula1/configs/app_settings.dart';
import 'package:flutter_aula1/models/produto.dart';
import 'package:flutter_aula1/repositories/conta_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProdutosDetalhesPage extends StatefulWidget {
  Produto produto;

  ProdutosDetalhesPage({Key? key, required this.produto}) : super(key: key);

  @override
  _ProdutosDetalhesPageState createState() => _ProdutosDetalhesPageState();
}

class _ProdutosDetalhesPageState extends State<ProdutosDetalhesPage> {
  late NumberFormat real;
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;
  late ContaRepository conta;

  comprar() async {
    if (_form.currentState!.validate()) {
      await conta.comprar(widget.produto, double.parse(_valor.text));

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Compra realizada com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    readNumberFormat();
    conta = Provider.of<ContaRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              widget.produto.nome,
              strutStyle: StrutStyle(
                forceStrutHeight: true,
              ),
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 0.8,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
              color: Colors.yellow,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.produto.nome,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(
                    child: Image.network(widget.produto.urlImage),
                    width: 300,
                  ),
                  Container(width: 10),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Text(
                  '$quantidade ${widget.produto.descricao}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                  ),
                ),
                margin: EdgeInsets.only(bottom: 24),
                // padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                // decoration: BoxDecoration(
                //   color: Colors.teal.withOpacity(0.05),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  readNumberFormat() {
    final loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }
}
