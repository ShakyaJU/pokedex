import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokipod/pages/splash_screen.dart';
import 'package:pokipod/pokedex.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServices();
  runApp(const ProviderScope(child: SplashWrapper()));
}

class SplashWrapper extends StatelessWidget {
  const SplashWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
