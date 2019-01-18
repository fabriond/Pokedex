import 'package:flutter/material.dart';
import 'package:pokedex/widgets/pokedex/simple_pokedex.dart';
import 'package:pokedex/resources/color_pallet.dart';
import 'package:pokedex/resources/http_client.dart';
import 'package:isolate/isolate_runner.dart';
import 'package:pokedex/screens/pokemon_list_screen.dart';
import 'dart:convert';

class PokedexList extends StatelessWidget {
  final List<SimplePokedex> pokedexes;

  PokedexList({Key key, this.pokedexes}) : super(key: key);

  static Future<List<SimplePokedex>> fetch() async {
    final response = await client.get('https://pokeapi.co/api/v2/pokedex/');
    final runner = await IsolateRunner.spawn();
    return runner.run(loadGenerations, response.body).whenComplete(() => runner.close());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPallet.body,
      child: GridView.builder(
        //each element is a card representing a pokedex
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: pokedexes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => PokemonListScreen(simplePokedex: pokedexes[index])
              )
            ),
            child: pokedexes[index]
          );
        },
      )
    );
  }
}

Future<List<SimplePokedex>> loadGenerations(String responseBody) async {
  List<dynamic> pokedexList = json.decode(responseBody)["results"];
  pokedexList.removeAt(0);
  return Stream.fromIterable(pokedexList).asyncMap((sp) => SimplePokedex.fromJson(sp)).toList();
}