import 'package:flutter/material.dart';
import 'package:pokedex/model/simple_pokemon.dart';
import 'package:pokedex/resources/color_pallet.dart';

class PokemonList extends StatelessWidget {
  final List<SimplePokemon> pokemons;

  PokemonList({Key key, this.pokemons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPallet.bodyColor,
      child: GridView.builder(
        //each element is a pokemon card
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          return pokemons[index].toWidget();
        },
      )
    );
  }
}