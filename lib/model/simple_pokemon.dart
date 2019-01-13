import 'package:pokedex/resources/color_pallet.dart';
import 'package:pokedex/model/pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'dart:convert';

class SimplePokemon {
  String name;
  String pokemonUrl;

  SimplePokemon({this.name, this.pokemonUrl});

  //https://pokeapi.co/api/v2/pokemon/
  factory SimplePokemon.fromJson(Map<String, dynamic> json){
    final name = ReCase(json["name"] as String);
    return SimplePokemon(
      name: name.titleCase,
      pokemonUrl: json["url"],
    );
  }

  Future<Pokemon> toPokemon() async {
    final resp = await http.get(pokemonUrl);
    if(resp.statusCode < 400){
      final pokemon = json.decode(resp.body);
      return Pokemon.fromJson(pokemon);
    } else{
      throw Exception('Connection error\nStatus: ' + resp.statusCode.toString());
    }
  }

  Widget toWidget(){
    return FutureBuilder<Pokemon>(
      future: toPokemon(),
      builder: (context, snapshot){
        if(snapshot.hasError) print(snapshot.error);
        if(snapshot.hasData){
          return snapshot.data.toSimpleWidget();
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
      color: ColorPallet.pokemonCardColor,
      child: Column(
        children: <Widget>[
          Placeholder(
            color: ColorPallet.pokemonCardColor,
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