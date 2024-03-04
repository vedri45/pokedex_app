import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonEvolutionTab extends StatelessWidget {
  final Pokemon pokemon;

  PokemonEvolutionTab({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Evolution Chain:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            '- ${_formatEvolution()}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  String _capitalize(String? s) {
    return s != null ? "${s[0].toUpperCase()}${s.substring(1)}" : '';
  }

  String _formatEvolution() {
    String formattedEvolution = '';
    for (int i = 0; i < pokemon.evolution.length; i++) {
      formattedEvolution += _capitalize(pokemon.evolution[i]);
      if (i < pokemon.evolution.length - 1) {
        formattedEvolution += ', ';
      }
    }

    return formattedEvolution;
  }
}
