import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_aula1/adapters/produto_hiver_adapter.dart';
import 'package:flutter_aula1/models/produto.dart';
import 'package:hive/hive.dart';

class FavoritasRepository extends ChangeNotifier {
  List<Produto> _lista = [];
  late LazyBox box;

  FavoritasRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavoritas();
  }

  _openBox() async {
    Hive.registerAdapter(MoedaHiveAdapter());
    box = await Hive.openLazyBox<Produto>('moedas_favoritas');
  }

  _readFavoritas() {
    box.keys.forEach((produto) async {
      Produto m = await box.get(produto);
      _lista.add(m);
      notifyListeners();
    });
  }

  UnmodifiableListView<Produto> get lista => UnmodifiableListView(_lista);

  saveAll(List<Produto> produtos) {
    produtos.forEach((produto) {
      if (!_lista.any((atual) => atual.descricao == produto.descricao)) {
        _lista.add(produto);
        box.put(produto.descricao, produto);
      }
    });
    notifyListeners();
  }

  remove(Produto produto) {
    _lista.remove(produto);
    box.delete(produto.descricao);
    notifyListeners();
  }
}
