import 'package:flutter/material.dart';
import 'package:pokedex/resources/color_pallet.dart';
import 'package:recase/recase.dart';
import 'package:pokedex/widgets/pokemon/pokemon_list.dart';
import 'package:pokedex/widgets/pokemon/simple_pokemon.dart';

class Pokedex extends StatelessWidget {
  final String region;
  final PokemonList pokemonList;

  Pokedex({this.region, this.pokemonList});

  factory Pokedex.fromJson(Map<String, dynamic> json){
    final regionName = ReCase((json["name"] as String).replaceAll("-", " "));
    final pokemons = (json["pokemon_entries"] as List<dynamic>).map((dyn) => SimplePokemon.fromJson(dyn)).toList();
    return Pokedex(
      region: regionName.titleCase,
      pokemonList: PokemonList(pokemons: pokemons)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(2.0),
      clipBehavior: Clip.hardEdge,
      color: ColorPallet.bodyContrast,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(this.region),
          Text("Pokedex")
        ]
      )
    );
  }
}