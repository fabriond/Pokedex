import 'package:flutter/material.dart';
import 'package:pokedex/resources/color_pallet.dart';
import 'package:pokedex/widgets/loading.dart';
import 'package:pokedex/widgets/pokedex_bulb.dart';
import 'package:pokedex/widgets/pokedex/simple_pokedex.dart';
import 'package:pokedex/widgets/pokedex/pokedex.dart';

class PokemonListScreen extends StatelessWidget {

  PokemonListScreen({Key key, this.simplePokedex}) : super(key: key);

  final SimplePokedex simplePokedex;

  //evolution chain is at pokemon -(link)> pokemon-species -(link)> evolution-chain

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: index());
  }

  Widget index(){
    return Scaffold(
      appBar: AppBar(
        leading: PokedexBulb(),
        title: Text(simplePokedex.region + " Pokedex"),
        centerTitle: true,
        backgroundColor: ColorPallet.appBar
      ),
      body: FutureBuilder<Pokedex>(
        future: simplePokedex.toPokedex(),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          if(snapshot.hasData){
            return snapshot.data.pokemonList;
          } else{
            return Loading();
          }
        },
      ),
    );
  }
}