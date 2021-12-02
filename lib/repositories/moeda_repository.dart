import 'package:flutter_aula1/models/moeda.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
        icone: 'images/bitcoin.png',
        preco: 322120.31,
        nome: 'BitCoin',
        sigla: 'BTC'),
    Moeda(
      icone: 'images/ethereum.png',
      preco: 25138.15,
      nome: 'Ethereum',
      sigla: 'ETH',
    ),
    Moeda(
      icone: 'images/litecoin.png',
      preco: 1150.01,
      nome: 'LiteCoin',
      sigla: 'LTC',
    ),
    Moeda(
      icone: 'images/xrp.png',
      preco: 5.65,
      nome: 'Ripple',
      sigla: 'XRP',
    ),
    Moeda(
      icone: 'images/dogecoin.png',
      preco: 1.22,
      nome: 'Dogecoin',
      sigla: 'DOGE',
    ),
  ];
}
