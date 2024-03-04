import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonApi {
  static const baseUrl = 'https://pokeapi.co/api/v2/pokemon/';

  static Future<http.Response> getPokemon(Uri uri) async =>
      await http.get(uri);

  static String getImageUrl(int pokemonId) =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png';

  static Future<List<Pokemon>> fetchPokemons(int offset, int fetchLimit) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?offset=$offset&limit=$fetchLimit'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return fetchPokemonDetails(results);
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }

  static Future<List<Pokemon>> fetchPokemonDetails(List<dynamic> pokemonList) async {
    final List<Pokemon> fetchedPokemons = [];

    for (final pokemon in pokemonList) {
      final response = await getPokemon(Uri.parse(pokemon['url']));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final List<String> abilities = data['abilities']
            .map<String>((ability) => ability['ability']['name'] as String)
            .toList();

        final List<int> stats = data['stats']
            .map<int>((stat) => stat['base_stat'] as int)
            .toList();

        final pokemonSpeciesUrl = Uri.parse(data['species']['url']);
        final evolution = await fetchPokemonEvolutionChain(pokemonSpeciesUrl);

        final Pokemon fetchedPokemon = Pokemon(
          id: data['id'],
          name: data['name'],
          type: data['types'][0]['type']['name'],
          height: data['height'],
          weight: data['weight'],
          ability: abilities,
          stats: stats,
          evolution: evolution,
        );
        fetchedPokemons.add(fetchedPokemon);
      } else {
        print('Failed to fetch details: ${response.statusCode}');
      }
    }
    return fetchedPokemons;
  }

  static Future<List<String>> fetchPokemonEvolutionChain(Uri pokemonSpeciesUrl) async {
    final List<String> evolutionChain = [];
    try {
      final response = await http.get(Uri.parse('$pokemonSpeciesUrl'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final pokemonEvolutionChainUrl = Uri.parse(data['evolution_chain']['url']);
        try {
          final response = await getPokemon(pokemonEvolutionChainUrl);
          if (response.statusCode == 200) {
            final Map<String, dynamic> data = json.decode(response.body);
            final chain = data['chain'];

            evolutionChain.add(chain['species']['name']);
            if (chain['evolves_to'].isNotEmpty) {
              evolutionChain.add(chain['evolves_to'][0]['species']['name']);
              if (chain['evolves_to'][0]['evolves_to'].isNotEmpty) {
                evolutionChain.add(chain['evolves_to'][0]['evolves_to'][0]['species']['name']);
              }
            }
          }
        } catch (error) {
          print('Error: $error');
        }
      } else {
        print('Failed to fetch evolution chain: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }

    return evolutionChain;
  }

  static Future<List<Pokemon>> fetchNextPokemon(int pokemonId) async =>
      await fetchPokemonById(pokemonId + 1);

  static Future<List<Pokemon>> fetchPreviousPokemon(int pokemonId) async =>
      await fetchPokemonById(pokemonId - 1);

  static Future<List<Pokemon>> fetchPokemonById(int pokemonId) async {
    final List<Pokemon> fetchedPokemons = [];
    try {
      final response = await http.get(Uri.parse('$baseUrl$pokemonId/'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final abilities = data['abilities']
            .map<String>((ability) => ability['ability']['name'] as String)
            .toList();

        final stats = data['stats']
            .map<int>((stat) => stat['base_stat'] as int)
            .toList();

        final pokemonSpeciesUrl = Uri.parse(data['species']['url']);
        final evolution = await fetchPokemonEvolutionChain(pokemonSpeciesUrl);

        final Pokemon fetchedPokemon = Pokemon(
          id: data['id'],
          name: data['name'],
          type: data['types'][0]['type']['name'],
          height: data['height'],
          weight: data['weight'],
          ability: abilities,
          stats: stats,
          evolution: evolution,
        );

        fetchedPokemons.add(fetchedPokemon);
      }
    } catch (error) {
      print('Error: $error');
    }
    return fetchedPokemons;
  }
}
