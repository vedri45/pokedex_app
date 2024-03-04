import 'package:flutter/material.dart';
import 'package:poke_app/widgets/pokemon_stats_tab.dart';
import '../models/pokemon.dart';
import 'pokemon_about_tab.dart';
import 'pokemon_evolution_tab.dart';

class PokemonDetailTabs extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetailTabs({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            tabs: [
              Tab(text: 'About'),
              Tab(text: 'Stats'),
              Tab(text: 'Evolution'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                PokemonAboutTab(pokemon: pokemon),
                PokemonStatsTab(pokemon: pokemon),
                PokemonEvolutionTab(pokemon: pokemon),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
