import 'package:flutter/material.dart';

class ColorUtil {
  static Color getBackgroundColor(String type) {
    switch (type.toLowerCase()) {
      case 'grass':
        return Colors.green[300] ?? Colors.green;
      case 'fire':
        return const Color.fromRGBO(251, 108, 108, 1);
      case 'water':
        return Colors.blue[300] ?? Colors.blue;
      case 'electric':
        return Colors.yellow[300] ?? Colors.yellow;
      case 'ice':
        return Colors.lightBlue[300] ?? Colors.lightBlue;
      case 'psychic':
        return Colors.purple[300] ?? Colors.purple;
      case 'rock':
        return Colors.brown[300] ?? Colors.brown;
      case 'ground':
        return Colors.orange[300] ?? Colors.orange;
      case 'flying':
        return Colors.indigo[300] ?? Colors.indigo;
      case 'bug':
        return Colors.greenAccent[300] ?? Colors.greenAccent;
      case 'poison':
        return Colors.purpleAccent[300] ?? Colors.purpleAccent;
      case 'fighting':
        return Colors.orange[300] ?? Colors.orange;
      case 'steel':
        return Colors.grey[300] ?? Colors.grey;
      case 'dragon':
        return Colors.deepPurple[300] ?? Colors.deepPurple;
      case 'ghost':
        return Colors.purple[300] ?? Colors.purple;
      case 'dark':
        return Colors.brown[300] ?? Colors.brown;
      case 'fairy':
        return Colors.pinkAccent[300] ?? Colors.pinkAccent;
      case 'normal': // New case
        return Colors.amber[300] ?? Colors.amber; // Choose appropriate color
      case 'electric': // New case
        return Colors.yellowAccent[300] ??
            Colors.yellowAccent; // Choose appropriate color
      case 'ground': // New case
        return Colors.orangeAccent[300] ??
            Colors.orangeAccent; // Choose appropriate color
      // Add more cases here as needed
      default:
        return Colors.grey[300] ?? Colors.grey;
    }
  }
}
