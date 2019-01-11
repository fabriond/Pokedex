import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Pokemon {
  int number;
  String name;
  String spriteURL;
  
  Pokemon({this.number, this.name, this.spriteURL});

  //https://pokeapi.co/api/v2/pokemon-form/1/
  factory Pokemon.fromJson(Map<String, dynamic> json){
    return Pokemon(
      number: json["id"],
      name: json["name"],
      spriteURL: json["sprites"]["front_default"]
    );
  }

  Widget toWidget(){
    return Card(
      margin: EdgeInsets.all(2.0),
      clipBehavior: Clip.hardEdge,
      color: Colors.red[700],
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: this.spriteURL,
            placeholder: new CircularProgressIndicator(strokeWidth: 3.0, semanticsLabel: 'loading...'),
            errorWidget: new Icon(Icons.error),
          ),
          Align(
            alignment: Alignment.bottomCenter, 
            child: Text(
              this.name[0].toUpperCase() + this.name.substring(1), 
              overflow: TextOverflow.ellipsis
            )
          )
        ]
      )
    );
  }
}