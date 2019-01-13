import 'package:pokedex/model/simple_pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:isolate/isolate_runner.dart';
import 'dart:convert';

class PokemonController {
  //https://pokeapi.co/api/v2/pokemon/
  static Future<List<SimplePokemon>> fetchList(http.Client client) async {
    final response = await client.get('https://pokeapi.co/api/v2/pokemon/');
    final runner = await IsolateRunner.spawn();
    return runner.run(loadPokemons, response.body).whenComplete(() => runner.close());
  }
}

Future<List<SimplePokemon>> loadPokemons(String responseBody) async {
  List<dynamic> pokemonList = json.decode(responseBody)["results"];
  return Stream.fromIterable(pokemonList).asyncMap((sp) => SimplePokemon.fromJson(sp)).toList();
}