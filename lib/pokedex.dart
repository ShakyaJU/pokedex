// lib/pokedex.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokipod/pages/home_page.dart';
import 'package:pokipod/services/database_service.dart';
import 'package:pokipod/services/http_service.dart';

Future<void> setupServices() async {
  GetIt.instance.registerSingleton<HTTPService>(HTTPService());
  GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PokéDex',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,
          textTheme: GoogleFonts.quattrocentoSansTextTheme(),
        ),
        home: const HomePage(),
      ),
    );
  }
}
