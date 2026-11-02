import 'package:flutter/material.dart';

import 'screens/lista_ativos_screen.dart';

void main() {
  runApp(const CarteiraApp());
}

class CarteiraApp extends StatelessWidget {
  const CarteiraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Carteira',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B5E4B)),
        useMaterial3: true,
      ),
      home: const ListaAtivosScreen(),
    );
  }
}
