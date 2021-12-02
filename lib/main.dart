import 'package:flutter/material.dart';
import 'package:flutter_aula1/configs/app_settings.dart';
import 'package:flutter_aula1/meu_aplicativo.dart';
import 'package:flutter_aula1/repositories/favoritas_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppSettings(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritasRepository(),
        ),
      ],
      child: MeuAplicativo(),
    ),
  );
}
