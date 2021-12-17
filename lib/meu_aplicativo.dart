import 'package:flutter/material.dart';
import 'package:flutter_aula1/pages/home_page.dart';
import 'package:flutter_aula1/pages/produto_form_page.dart';
import 'package:flutter_aula1/routes/app_routes.dart';

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cripto Moedas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      // home: HomePage(),
      routes: {
        AppRoutes.HOME: (_) => HomePage(),
        AppRoutes.PRODUTO_FORM: (ctx) => ProdutoForm(),
      },
    );
  }
}
