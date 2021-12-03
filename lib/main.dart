import 'package:flutter/material.dart';
import 'package:flutter_aula1/configs/app_settings.dart';
import 'package:flutter_aula1/configs/hive_config.dart';
import 'package:flutter_aula1/repositories/conta_repository.dart';
import 'package:flutter_aula1/repositories/favoritas_repository.dart';
import 'package:provider/provider.dart';
import 'meu_aplicativo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContaRepository()),
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(create: (context) => FavoritasRepository()),
      ],
      child: MeuAplicativo(),
    ),
  );
}
