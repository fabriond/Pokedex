import 'package:flutter/material.dart';
import 'color_pallet.dart';

class PokedexBulb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: ColorPallet.pokedexBulb,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorPallet.pokedexBulbLight,
            blurRadius: 15.0
          )
        ],
        border: Border.all(
          color: ColorPallet.pokedexBulbBorder,
          width: 3.0
        )
      )
    );
  }
}