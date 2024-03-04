import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonAboutTab extends StatelessWidget {
  final Pokemon pokemon;

  PokemonAboutTab({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Height: ${pokemon.height} cm',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'Weight: ${pokemon.weight} kg',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'Abilities: ${_formatAbilities()}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  String _capitalize(String? s) {
    return s != null ? "${s[0].toUpperCase()}${s.substring(1)}" : '';
  }

  String _formatAbilities() {
    String formattedAbilities = '';
    for (int i = 0; i < pokemon.ability.length; i++) {
      formattedAbilities += _capitalize(pokemon.ability[i]);
      if (i < pokemon.ability.length - 1) {
        formattedAbilities += ', ';
      }
    }
    return formattedAbilities;
  }
}
