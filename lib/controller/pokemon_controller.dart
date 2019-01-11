import 'package:pokedex/model/pokemon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:collection';
import 'package:flutter/material.dart';

class PokemonController {

  Map<int, Pokemon> pokemons;
  Map<int, Widget> widgets;
  int pokemonCount = -1;

  PokemonController(){
    pokemons = new SplayTreeMap();
    widgets = new SplayTreeMap();
  }

  //https://pokeapi.co/api/v2/pokemon-form/
  //adds a pokemon to the "pokemons" map, and its widget to the "widgets" map
  Future<void> addPokemon(String pokemonListJson){
    ++pokemonCount;
    List<dynamic> pokemonList = json.decode(pokemonListJson)["results"];
    Future<Pokemon> pokemon = fetchData(pokemonList[pokemonCount]);
    return pokemon.then((p) {pokemons.putIfAbsent(p.number, () => p); widgets.putIfAbsent(p.number, p.toWidget);});
  }

  //fectches the pokemon's data from the url in the pokemon info from the pokemon list
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
    return widgets.values.toList();
  }
}