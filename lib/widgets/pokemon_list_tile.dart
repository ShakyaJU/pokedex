import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokipod/models/pokemon.dart';
import 'package:pokipod/providers/pokemon_data_providers.dart';
import 'package:pokipod/widgets/pokemon_stats_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListTile extends ConsumerWidget {
  final String pokemonURL;

  const PokemonListTile({super.key, required this.pokemonURL});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouritePokemonsProvider = ref.watch(favouritePokemonProvider.notifier);
    final favouritePokemons = ref.watch(favouritePokemonProvider);
    final pokemon = ref.watch(pokemonDataProvider(pokemonURL));

    return pokemon.when(
      data: (data) {
        return _tile(context, false, data, favouritePokemonsProvider, favouritePokemons);
      },
      error: (error, stackTrace) {
        return Text('Error: $error');
      },
      loading: () {
        return _tile(context, true, null, favouritePokemonsProvider, favouritePokemons);
      },
    );
  }

  Widget _tile(
    BuildContext context,
    bool isLoading,
    Pokemon? pokemon,
    FavouritePokemonsProvider favouritePokemonsProvider,
    List<String> favouritePokemons,
  ) {
    return Skeletonizer(
      enabled: isLoading,
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
        child: ListTile(
          leading: pokemon != null ? CircleAvatar(backgroundImage: NetworkImage(pokemon.sprites!.frontDefault!)) : const CircleAvatar(),
          title: Text(pokemon != null ? pokemon.name!.toUpperCase() : "Currently loading name for Pokemon."),
          subtitle: Text('Has ${pokemon?.moves?.length.toString() ?? "0"} moves'),
          trailing: IconButton(
            onPressed: () {
              if (favouritePokemons.contains(pokemonURL)) {
                favouritePokemonsProvider.removeFavoritePokemon(pokemonURL);
              } else {
                favouritePokemonsProvider.addFavoritePokemon(pokemonURL);
              }
            },
            icon: Icon(favouritePokemons.contains(pokemonURL) ? Icons.favorite : Icons.favorite_border, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
