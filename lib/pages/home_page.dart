import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokipod/controllers/home_page_controller.dart';
import 'package:pokipod/models/page_data.dart';
import 'package:pokipod/models/pokemon.dart';
import 'package:pokipod/providers/pokemon_data_providers.dart';
import 'package:pokipod/widgets/pokemon_card.dart';
import 'package:pokipod/widgets/pokemon_list_tile.dart';

final homePageControllerProvider = StateNotifierProvider<HomePageController, HomePageData>((ref) {
  return HomePageController(HomePageData.initial());
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _allPokemonListScrollController = ScrollController();

  late HomePageController _homePageController;
  late HomePageData _homePageData;
  late List<String> _favouritePokemons;

  @override
  Widget build(BuildContext context) {
    _homePageController = ref.watch(homePageControllerProvider.notifier);
    _homePageData = ref.watch(homePageControllerProvider);
    _favouritePokemons = ref.watch(favouritePokemonProvider);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('PokéDex', style: TextStyle(fontWeight: FontWeight.bold, fontSize:30,)),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   elevation: 4,
      // ),
      appBar: AppBar(
        title: Image.asset(
          'assets/pokedex.png',
          height: 50, // adjust height as needed
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 4,
      ),

      body: _buildUI(context),
      backgroundColor: Colors.grey[100],
    );
  }

  @override
  void initState() {
    super.initState();
    _allPokemonListScrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _allPokemonListScrollController.removeListener(_scrollListener);
    _allPokemonListScrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_allPokemonListScrollController.offset >= _allPokemonListScrollController.position.maxScrollExtent - 200) {
      _homePageController.loadData();
    }
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('Favourites'),
              const SizedBox(height: 12),
              _favouritePokemonsList(context),
              const SizedBox(height: 24),
              _sectionTitle('All Pokémons'),
              const SizedBox(height: 12),
              _allPokemonList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.black87, letterSpacing: 1.1),
    );
  }

  Widget _favouritePokemonsList(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.42,
      child: _favouritePokemons.isEmpty
          ? Center(
              child: Text(
                'No favourite pokemons yet! :(',
                style: TextStyle(color: Colors.grey[700], fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          : GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85, // Adjusted for better card fit
              ),
              itemCount: _favouritePokemons.length,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, index) {
                String pokemonURL = _favouritePokemons[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  shadowColor: Colors.grey.shade50, // lighter subtle shadow
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PokemonCard(pokemonURL: pokemonURL),
                  ),
                );
              },
            ),
    );
  }

  Widget _allPokemonList(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.62,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.grey.shade200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ListView.separated(
            controller: _allPokemonListScrollController,
            itemCount: _homePageData.data?.results?.length ?? 0,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              PokemonListResult pokemon = _homePageData.data!.results![index];
              return PokemonListTile(pokemonURL: pokemon.url!);
            },
          ),
        ),
      ),
    );
  }
}
