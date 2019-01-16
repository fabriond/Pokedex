import 'package:pokedex/controller/pokemon_controller.dart';
import 'package:pokedex/resources/pokemon_list.dart';
import 'package:pokedex/resources/color_pallet.dart';
import 'package:pokedex/model/simple_pokemon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/resources/pokedex_bulb.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  DefaultState createState() => DefaultState();
}

class DefaultState extends State<HomePage> {

  //evolution chain is at pokemon -(link)> pokemon-species -(link)> evolution-chain
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: index());
  }

  Widget index(){
    return Scaffold(
      appBar: AppBar(
        leading: PokedexBulb(),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: FutureBuilder<List<SimplePokemon>>(
        future: PokemonController.fetchList(),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          if(snapshot.hasData){
            return PokemonList(pokemons: snapshot.data);
          } else{
            return loadingScreen();
          }
        },
      ),
    );
  }

  Widget loadingScreen(){
    return Container(
      color: ColorPallet.body,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              strokeWidth: 3.0, 
              valueColor: AlwaysStoppedAnimation<Color>(ColorPallet.appBar)
            ),
            Text('Loading...', textAlign: TextAlign.center)
          ],
        )
      )
    );
  }
}