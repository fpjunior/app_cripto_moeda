import 'package:flutter/material.dart';
import 'package:flutter_aula1/models/produto.dart';
import 'package:hive/hive.dart';

class ProdutoRepository extends ChangeNotifier {
  LazyBox? box;

  static List<Produto> tabela = [
    Produto(
        urlImage:
            'https://product-hub-prd.madeiramadeira.com.br/2796580/images/2796580__4.jpg?width=500&canvas=1:1&bg-color=FFF',
        preco: 290.29,
        nome: 'Sofa De Palete Em Pinus 2 Lugares',
        descricao:
            '(Tamanho C1000 X L800 X A670), Especificações: Dimensão: (C-L-A) 100cm x 80cm x 67cm Peso do Produto: 28 kilos Dimensão caixa de transporte: (C-L-A) 290x185x1000'),
    Produto(
      urlImage:
          'https://villapano.com.br/pub/media/catalog/product/cache/b468e7d8efda75ab01d8945b6b4112bd/2/3/2392_medidas_.jpg',
      preco: 42.00,
      nome: 'TÁBUA DE CORTE LAMOUR',
      descricao: 'Medidas: 24cm x 18cm x 2cm',
    ),
    Produto(
      urlImage:
          'https://img.elo7.com.br/product/zoom/37B7BA0/kit-3-tabua-descanso-de-panela-em-madeira-pinus-coracao-pinus.jpg',
      preco: 98.90,
      nome: 'Kit 3 Tabua Descanso de Panela',
      descricao:
          'MEDIDAS 1. tábua em formato de coraçãoComprimento:23 cmLargura:24,5cmEspessura:1,5cm 2. tábua para redonda Comprimento: 35,2cm Largura: 28cm Espessura:1,5cm 3. tábua retangular de coração Comprimento: 46cm Largura:15cm Espessura:1,5cm',
    ),
    Produto(
      urlImage:
          'https://cf.shopee.com.br/file/ec1ec3ddc5b89ccea923935dfe794868 ',
      preco: 71.24,
      nome: 'Casinha Madeira',
      descricao:
          'Medidas externas considerando a casinha montada: Comprimento: 54 Altura: 46 cm Largura: 37 Medidas Interna: Comprimento: 44cm Altura: 38 cm Largura: 30 cm Medida da porta: Altura: 22 cm. Largura: 15 cm',
    ),
    Produto(
      urlImage:
          'https://cf.shopee.com.br/file/e4531011a17c106c64574bf243907319',
      preco: 15.60,
      nome: 'Mini Caixa',
      descricao: '20 cm comp. x 11,5 cm larg. x 7 cm altura',
    ),
  ];

  void put(Produto produto) {
    if (box == null) {
      return;
    }

    tabela.add(Produto(
      urlImage:
          'https://cf.shopee.com.br/file/e4531011a17c106c64574bf24390731900',
      preco: produto.preco,
      nome: 'Mini Caixa',
      descricao: '200 cm comp. x 11,5 cm larg. x 7 cm altura',
    ));
    // else {
    // box.put(produto.nome, produto);
    // }
    notifyListeners();
  }
}
