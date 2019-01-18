import 'package:pokedex/resources/color_pallet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/widgets/pokedex_bulb.dart';
import 'package:pokedex/widgets/pokedex/pokedex_list.dart';
import 'package:pokedex/widgets/pokedex/simple_pokedex.dart';
import 'package:pokedex/widgets/loading.dart';

class HomeScreen extends StatelessWidget {
  
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: index());
  }

  Widget index(){
    return Scaffold(
      appBar: AppBar(
        leading: PokedexBulb(),
        title: Text(title),
        centerTitle: true,
        backgroundColor: ColorPallet.appBar
      ),
      body: FutureBuilder<List<SimplePokedex>>(
        future: PokedexList.fetch(),
        builder: (context, snapshot) {
          if(snapshot.hasError) print(snapshot.error);
          if(snapshot.hasData){
            return PokedexList(pokedexes: snapshot.data);
          } else{
            return Loading();
          }
        },
      ),
    );
  }
}