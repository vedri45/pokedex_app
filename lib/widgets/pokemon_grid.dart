import 'package:flutter/material.dart';
import '../utils/color_util.dart';
import '../models/pokemon.dart';
import '../services/pokemon_api.dart';

class PokemonGrid extends StatelessWidget {
  final List<Pokemon> pokemons;
  final void Function(int) onPokemonTap;
  final ScrollController listController;

  PokemonGrid({
    required this.pokemons,
    required this.onPokemonTap,
    required this.listController,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: listController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: pokemons.length + 1,
      itemBuilder: (context, index) {
        if (index < pokemons.length) {
          final pokemon = pokemons[index];
          final bgColor = ColorUtil.getBackgroundColor(pokemon.type);
          return Card(
            color: bgColor,
            elevation: 3,
            margin: EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                onPokemonTap(index);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'pokemon-${pokemons[index].id}',
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          PokemonApi.getImageUrl(pokemons[index].id)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _capitalize(pokemons[index].name),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white12),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        _capitalize(pokemons[index].type),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  String _capitalize(String? s) {
    return s != null ? "${s[0].toUpperCase()}${s.substring(1)}" : '';
  }
}
