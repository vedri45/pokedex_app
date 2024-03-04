class Pokemon {
  final String name;
  final String type;
  final int id;
  final int height;
  final int weight;
  final List ability;
  final List stats;
  final List evolution;

  Pokemon({
    required this.name,
    required this.type,
    required this.id,
    required this.height,
    required this.weight,
    required this.ability,
    required this.stats,
    required this.evolution,
  });
}
