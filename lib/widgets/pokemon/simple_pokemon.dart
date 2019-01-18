import 'package:pokedex/resources/color_pallet.dart';
import 'package:pokedex/resources/http_client.dart';
import 'package:pokedex/widgets/pokemon/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'dart:convert';

class SimplePokemon extends StatelessWidget{
  final int number;
  final String name;
  final String pokemonUrl;

  SimplePokemon({this.number, this.name, this.pokemonUrl});

  //https://pokeapi.co/api/v2/pokemon/
  factory SimplePokemon.fromJson(Map<String, dynamic> json){
    final pkmn = json["pokemon_species"];
    final name = ReCase(pkmn["name"] as String);
    final url = (pkmn["url"] as String).replaceAll("pokemon-species", "pokemon");
    return SimplePokemon(
      number: json["entry_number"],
      name: name.titleCase,
      pokemonUrl: url,
    );
  }

  Future<Pokemon> toPokemon() async {
    final resp = await client.get(pokemonUrl);
    if(resp.statusCode < 400){
      final pokemon = json.decode(resp.body);
      return Pokemon.fromJson(pokemon);
    } else{
      throw Exception('Connection error\nStatus: ' + resp.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context){
    return FutureBuilder<Pokemon>(
      future: toPokemon(),
      builder: (context, snapshot){
        if(snapshot.hasError) print(snapshot.error);
        if(snapshot.hasData){
          return snapshot.data;
        } else{
          return loadingPokemon();
        }
      }  
    );
  }

  Widget loadingPokemon(){
    return Card(
      margin: EdgeInsets.all(2.0),
      clipBehavior: Clip.hardEdge,
      color: ColorPallet.pokemonCard,
      child: Column(
        children: <Widget>[
          Placeholder(
            color: ColorPallet.pokemonCard,
            fallbackHeight: 96.0,
            fallbackWidth: 96.0,
          ),
          Align(
            alignment: Alignment.bottomCenter, 
            child: Text(
              this.name,
              overflow: TextOverflow.ellipsis
            )
          )
        ]
      )
    );
  }

}