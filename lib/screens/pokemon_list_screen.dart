import 'package:flutter/material.dart';
import '../screens/pokemon_detail.screen.dart';

import '../models/pokemon.dart';
import '../widgets/pokemon_grid.dart';
import '../services/pokemon_api.dart';

class PokemonListScreen extends StatefulWidget {
  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  List<Pokemon> pokemons = [];
  List<Pokemon> filteredPokemons = [];
  TextEditingController searchController = TextEditingController();
  ScrollController listController = ScrollController();

  bool showSearchBar = false;
  bool isFetching = false;
  int offset = 0;
  int fetchLimit = 10;

  @override
  void initState() {
    super.initState();
    _fetchPokemons();
    listController.addListener(() {
      if (listController.position.pixels == listController.position.maxScrollExtent) {
        _fetchMorePokemons();
      }
    });
  }

  @override
  void dispose() {
    listController.dispose();
    super.dispose();
  }

  Future<void> _fetchPokemons() async {
    setState(() {
      isFetching = true;
    });
    List<Pokemon> fetchedPokemons = await PokemonApi.fetchPokemons(offset, fetchLimit);

    setState(() {
      pokemons = fetchedPokemons;
      filteredPokemons = fetchedPokemons;
      isFetching = false;
    });
  }

  Future<void> _fetchMorePokemons() async {
    setState(() {
      offset = offset+10;
    });

    List<Pokemon> fetchedPokemons = await PokemonApi.fetchPokemons(offset, fetchLimit);
    setState(() {
      filteredPokemons.addAll(fetchedPokemons);
    });
  }

  void _filterPokemons(String query) {
    setState(() {
      filteredPokemons = pokemons
          .where((pokemon) =>
              pokemon.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                showSearchBar = !showSearchBar;
                if (!showSearchBar) {
                  searchController.clear();
                  _filterPokemons('');
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (showSearchBar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Pokemon...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      _filterPokemons('');
                    },
                  ),
                ),
                onChanged: (value) {
                  _filterPokemons(value);
                },
              ),
            ),
          Expanded(
            child: isFetching
                ? Center(child: CircularProgressIndicator())
                : filteredPokemons.isNotEmpty
                    ? PokemonGrid(
                        pokemons: filteredPokemons,
                        onPokemonTap: _onPokemonTap,
                        listController: listController)
                    : Center(child: Text('No Pokemon found')),
          ),
        ],
      ),
    );
  }

  void _onPokemonTap(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PokemonDetailScreen(pokemon: filteredPokemons[index]),
      ),
    );
  }
}
