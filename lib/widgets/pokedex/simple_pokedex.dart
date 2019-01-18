import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:pokedex/resources/color_pallet.dart';
import 'package:pokedex/widgets/pokedex/pokedex.dart';
import 'package:pokedex/resources/http_client.dart';
import 'dart:convert';

class SimplePokedex extends StatelessWidget {
  final String region;
  final String infoUrl;

  SimplePokedex({this.region, this.infoUrl});

  factory SimplePokedex.fromJson(Map<String, dynamic> json){
    final name = ReCase((json["name"] as String).replaceAll("-", " "));
    return SimplePokedex(
      region: name.titleCase,
      infoUrl: json["url"] as String
    );
  }

  Future<Pokedex> toPokedex() async {
    final resp = await client.get(infoUrl);
    if(resp.statusCode < 400){
      final gen = json.decode(resp.body);
      return Pokedex.fromJson(gen);
    } else{
      throw Exception('Connection error\nStatus: ' + resp.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pokedex>(
      future: toPokedex(),
      builder: (context, snapshot){
        if(snapshot.hasError) print(snapshot.error);
        if(snapshot.hasData){
          return snapshot.data;
        } else{
          return loadingPokedex();
        }
      }  
    );
  }

  Widget loadingPokedex(){
    return Card(
      margin: EdgeInsets.all(2.0),
      clipBehavior: Clip.hardEdge,
      color: ColorPallet.bodyContrast,
      child: Column(
        children: <Widget>[
          Placeholder(
            color: ColorPallet.bodyContrast,
            fallbackHeight: 96.0,
            fallbackWidth: 96.0,
          ),
          Align(
            alignment: Alignment.bottomCenter, 
            child: Text(
              this.region,
              overflow: TextOverflow.ellipsis
            )
          )
        ]
      )
    );
  }
}