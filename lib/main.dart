import 'package:artsionic_app/PostGeneration.dart';
import 'package:artsionic_app/imageGeneration.dart';
import 'package:artsionic_app/TrendFiltration.dart';
import 'package:artsionic_app/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/itemsState.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ItemsState(),
        ),
      ],
      child: MaterialApp(
        title: 'Artsionic',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const MyHomePage(title: 'Main Menu'),
          '/images': (context) =>
              ImageGenerationPage(title: "Image Generation"),
          '/posts': (context) => PostGenerationPage(title: "Post Generation"),
          '/trends': (context) => TrendFiltrationPage(title: "Trend Filtration")
        },
      ),
    );
  }
}
