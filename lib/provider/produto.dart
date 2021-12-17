import 'package:flutter/material.dart';
import 'package:flutter_aula1/models/produto.dart';

class ProdutosProvider with ChangeNotifier {
  final Map<String, Produto> _produtos = {};

  // List<Produto> _produtos = [];

  List<Produto> get allProdutos {
    return [..._produtos.values];
  }

  int get countProdutos {
    return _produtos.length;
  }

  Produto byIndex(int i) {
    return _produtos.values.elementAt(i);
  }
}
