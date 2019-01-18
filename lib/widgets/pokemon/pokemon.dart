import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex/resources/color_pallet.dart';
import 'package:recase/recase.dart';

class Pokemon extends StatelessWidget {
  final int number;
  final String name;
  final String spriteURL;
  
  Pokemon({this.number, this.name, this.spriteURL});

  //https://pokeapi.co/api/v2/pokemon/1/
  factory Pokemon.fromJson(Map<String, dynamic> json){
    final name = ReCase((json["name"] as String).replaceAll("-", " "));
    return Pokemon(
      number: json["id"] as int,
      name: name.titleCase,
      spriteURL: json["sprites"]["front_default"] as String
    );
  }

  @override
  Widget build(BuildContext context){
    return Card(
      margin: EdgeInsets.all(2.0),
      clipBehavior: Clip.hardEdge,
      color: ColorPallet.pokemonCard,
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: this.spriteURL,
            placeholder: Placeholder(
              color: ColorPallet.pokemonCard,
              fallbackHeight: 96.0,
              fallbackWidth: 96.0,
            ),
            errorWidget: new Icon(Icons.error, size: 96.0),
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