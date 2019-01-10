import 'package:pokedex/model/pokemon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonController {

  List<Pokemon> pokemons;

  PokemonController({this.pokemons});
  
  //TODO: make this function async so we can load pokemons faster
  //https://pokeapi.co/api/v2/pokemon-form/
  Future<void> addPokemons(String pokemonListJson){
    List<dynamic> pokemonList = json.decode(pokemonListJson)["results"];
    Future<Pokemon> pokemon = fetchData(pokemonList[pokemons.length]);
    return pokemon.then((p) => pokemons.add(p));
  }

  Future<Pokemon> fetchData(Map<String, dynamic> pokemon) async {
    //pokemon has name and url as keys
    final response = await http.get(pokemon["url"]);
    if(response.statusCode < 400){
      final _json = json.decode(response.body);
      return Pokemon.fromJson(_json);
    } else {
      throw Exception('Connection error\nStatus: ' + response.statusCode.toString());
    }
  }

  List<Widget> getWidgets(){
    List<Widget> images = [];
    for (var pokemon in pokemons) {
      images.add(
        Card(
          margin: EdgeInsets.all(2.0),
          clipBehavior: Clip.hardEdge,
          color: Colors.red[700],
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: pokemon.spriteURL,
                placeholder: new CircularProgressIndicator(strokeWidth: 3.0, semanticsLabel: 'loading...'),
                errorWidget: new Icon(Icons.error),
              ),
              Align(
                alignment: Alignment.bottomCenter, 
                child: Text(
                  pokemon.name[0].toUpperCase() + pokemon.name.substring(1), 
                  overflow: TextOverflow.ellipsis
                )
              )
            ]
          )
        )
      );
    }

    return images;
  }
}