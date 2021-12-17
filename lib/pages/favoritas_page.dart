import 'package:flutter/material.dart';
import 'package:flutter_aula1/repositories/favoritas_repository.dart';
import 'package:flutter_aula1/widget/moeda_card.dart';
import 'package:provider/provider.dart';

class FavoritasPage extends StatefulWidget {
  FavoritasPage({Key? key}) : super(key: key);

  @override
  _FavoritasPageState createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos Favoritas'),
      ),
      body: Container(
        color: Colors.indigo.withOpacity(0.05),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),
        child: Consumer<FavoritasRepository>(
          builder: (context, favoritas, child) {
            return favoritas.lista.isEmpty
                ? ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Ainda não há produtos favoritas'),
                  )
                : ListView.builder(
                    itemCount: favoritas.lista.length,
                    itemBuilder: (_, index) {
                      return MoedaCard(produto: favoritas.lista[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}
