import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokipod/models/pokemon.dart';
import 'package:pokipod/providers/pokemon_data_providers.dart';
import 'package:pokipod/widgets/pokemon_stats_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonCard extends ConsumerWidget {
  final String pokemonURL;

  late FavouritePokemonsProvider _favouritePokemonsProvider;

  PokemonCard({super.key, required this.pokemonURL});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _favouritePokemonsProvider = ref.watch(favouritePokemonProvider.notifier);
    final pokemon = ref.watch(pokemonDataProvider(pokemonURL));
    return pokemon.when(
      data: (data) {
        return _card(context, false, data);
      },
      error: (error, StackTrace) {
        return Text('Error: $error');
      },
      loading: () {
        return _card(context, true, null);
      },
    );
  }

  Widget _card(BuildContext context, bool isLoading, Pokemon? pokemon) {
    return Skeletonizer(
      enabled: isLoading,
      ignoreContainers: true,
      child: GestureDetector(
        onTap: () {
          if (!isLoading) {
            showDialog(
              context: context,
              builder: (_) {
                return PokemonStatsCard(pokemonURL: pokemonURL);
              },
            );
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.03,
            vertical: MediaQuery.sizeOf(context).height * 0.01,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.03,
            vertical: MediaQuery.sizeOf(context).height * 0.01,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: const [BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 10)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    pokemon?.name?.toUpperCase() ?? 'Pokemon',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '#${pokemon?.id?.toString()}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Expanded(
                child: CircleAvatar(
                  backgroundImage: pokemon != null ? NetworkImage(pokemon.sprites!.frontDefault!) : null,
                  radius: MediaQuery.sizeOf(context).height * 0.05,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${pokemon?.moves?.length} Moves',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      _favouritePokemonsProvider.removeFavoritePokemon(pokemonURL);
                    },
                    child: const Icon(Icons.favorite, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
