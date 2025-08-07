import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokipod/providers/pokemon_data_providers.dart';

class PokemonStatsCard extends ConsumerWidget {
  final String pokemonURL;

  const PokemonStatsCard({super.key, required this.pokemonURL});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonDataProvider(pokemonURL));

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      content: pokemon.when(
        data: (data) {
          if (data == null) {
            return const Text('No data available');
          }

          final imageUrl = data.sprites?.frontDefault;
          final name = data.name ?? 'Unknown';

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imageUrl != null) Image.network(imageUrl, height: 100, fit: BoxFit.contain),
              const SizedBox(height: 12),
              Text(
                name.toUpperCase(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              ...data.stats?.map((s) {
                    final statName = s.stat?.name ?? '';
                    final baseStat = s.baseStat ?? 0;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(statName.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w500)),
                          Text(baseStat.toString()),
                        ],
                      ),
                    );
                  }).toList() ??
                  [const Text("No stats available")],
            ],
          );
        },
        error: (error, stackTrace) {
          return Text('Error: $error');
        },
        loading: () {
          return const SizedBox(height: 100, child: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
