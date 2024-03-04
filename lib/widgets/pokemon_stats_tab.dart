import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonStatsTab extends StatelessWidget {
  final Pokemon pokemon;

  PokemonStatsTab({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatRow('HP', pokemon.stats[0]),
          _buildStatRow('Attack', pokemon.stats[1]),
          _buildStatRow('Defense', pokemon.stats[2]),
          _buildStatRow('Sp. Atk', pokemon.stats[3]),
          _buildStatRow('Sp. Def', pokemon.stats[4]),
          _buildStatRow('Speed', pokemon.stats[5]),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, int value) {
  Color progressColor = value < 50 ? Colors.red : Colors.green;

  return Row(
    children: [
      Expanded(
        flex: 1.toInt(),
        child: Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        flex: 0.5.toInt(),
        child: Text(
          value.toString(),
          style: TextStyle(fontSize: 16),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        flex: 3.5.toInt(),
        child: LinearProgressIndicator(
          value: value / 100,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        ),
      ),
    ],
  );
}

}
