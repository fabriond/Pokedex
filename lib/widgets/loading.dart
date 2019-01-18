import 'package:flutter/material.dart';
import 'package:pokedex/resources/color_pallet.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      color: ColorPallet.body,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              strokeWidth: 3.0, 
              valueColor: AlwaysStoppedAnimation<Color>(ColorPallet.bodyContrast)
            ),
            Text('Loading...', textAlign: TextAlign.center)
          ],
        )
      )
    );
  }
}