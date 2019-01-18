import 'package:flutter/material.dart';
import 'package:pokedex/widgets/pokemon/simple_pokemon.dart';
import 'package:pokedex/resources/color_pallet.dart';
import 'package:pokedex/resources/http_client.dart';
import 'package:isolate/isolate_runner.dart';
import 'dart:convert';

class PokemonList extends StatelessWidget {
  final List<SimplePokemon> pokemons;

  PokemonList({Key key, this.pokemons}) : super(key: key);

  static Future<List<SimplePokemon>> fetch() async {
    final response = await client.get('https://pokeapi.co/api/v2/pokemon/');
    final runner = await IsolateRunner.spawn();
    return runner.run(loadPokemons, response.body).whenComplete(() => runner.close());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPallet.body,
      child: GridView.builder(
        //each element is a pokemon card
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          return pokemons[index];
        },
      )
    );
  }
}

Future<List<SimplePokemon>> loadPokemons(String responseBody) async {
  List<dynamic> pokemonList = json.decode(responseBody)["results"];
  return Stream.fromIterable(pokemonList).asyncMap((sp) => SimplePokemon.fromJson(sp)).toList();
}