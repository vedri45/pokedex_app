import 'package:flutter/material.dart';
import '../utils/color_util.dart';
import '../models/pokemon.dart';
import '../services/pokemon_api.dart';
import '../widgets/pokemon_detail_tabs.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetailScreen({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = ColorUtil.getBackgroundColor(pokemon.type);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _capitalize(pokemon.name),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 150,
            right: -50,
            child: Image.asset(
              'assets/pokedex_icons.png',
              fit: BoxFit.cover,
              color: Colors.white24,
            ),
          ),
          _buildPokemonDetails(pokemon),
          _buildNavigationButtons(context, pokemon),
        ],
      ),
    );
  }

  Widget _buildPokemonDetails(Pokemon pokemon) {
    return Container(
      margin: EdgeInsets.only(top: 100.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Hero(
              tag: 'pokemon-${pokemon.id}',
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.transparent,
                backgroundImage:
                    NetworkImage(PokemonApi.getImageUrl(pokemon.id)),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: PokemonDetailTabs(pokemon: pokemon),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context, Pokemon pokemon) {
    return Stack(
      children: [
        Positioned(
          bottom: 10,
          left: 10,
          child: ElevatedButton(
            onPressed: () async {
              List<Pokemon> fetchedPokemons =
                  await PokemonApi.fetchPreviousPokemon(pokemon.id);
              int index = 0;
              if (fetchedPokemons.isNotEmpty) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PokemonDetailScreen(pokemon: fetchedPokemons[index]),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            child: Text('Previous'),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: ElevatedButton(
            onPressed: () async {
              List<Pokemon> fetchedPokemons =
                  await PokemonApi.fetchNextPokemon(pokemon.id);
              int index = 0;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PokemonDetailScreen(pokemon: fetchedPokemons[index]),
                ),
              );
            },
            child: Text('Next'),
          ),
        ),
      ],
    );
  }

  String _capitalize(String? s) {
    return s != null ? "${s[0].toUpperCase()}${s.substring(1)}" : '';
  }
}
