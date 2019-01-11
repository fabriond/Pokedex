import 'package:pokedex/model/pokemon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class PokemonController {

  List<Pokemon> pokemons;
  int pokemonCount = -1;

  PokemonController({this.pokemons});
  
  //TODO: make this function async so we can load pokemons faster
  //https://pokeapi.co/api/v2/pokemon-form/
  Future<void> addPokemons(String pokemonListJson){
    ++pokemonCount;
    List<dynamic> pokemonList = json.decode(pokemonListJson)["results"];
    Future<Pokemon> pokemon = fetchData(pokemonList[pokemonCount]);
    return pokemon.then((p) {pokemons.add(p); pokemons.sort((a, b) => a.number - b.number);});
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

  List<Widget> getWidgets() {
    List<Widget> images = [];
    for (var pokemon in pokemons) {
      images.add(pokemon.toWidget());
    }
  
    return images;
  }
}