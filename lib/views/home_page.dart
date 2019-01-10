import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/controller/pokemon_controller.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.backgroundColor}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final Color backgroundColor;

  @override
  DefaultState createState() => DefaultState();
}

class DefaultState extends State<HomePage> {
  
  final pokemonController = new PokemonController(pokemons: []);
  final scrollController = new ScrollController();
  List<Widget> pokemons = [Text("Empty List")];
  bool loading = false;

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    print(scrollController.position.extentAfter);
    if(scrollController.position.extentAfter < 500){
      fetchPokemons(18);
    }
  }

  void fetchPokemons(int count) async {
    if(!loading){
      loading = true;
      final response = await http.get('https://pokeapi.co/api/v2/pokemon/');
      if(response.statusCode < 400) {
        for(int i = 0; i < count-1; i++){
          await pokemonController.addPokemons(response.body);
        }

        pokemonController.addPokemons(response.body).then((v) { 
          setState(() {
            loading = false;
            pokemons = pokemonController.getWidgets();
          });
        });
      } else {
        throw Exception('Connection error\nStatus: ' + response.statusCode.toString());
      }
    } else {
      return;
    }
  }

  //evolution chain is at pokemon -(link)> pokemon-species -(link)> evolution-chain

  Widget loadingScreen(){
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        color: widget.backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(strokeWidth: 3.0),
              Text('Loading...', textAlign: TextAlign.center)
            ],
          )
        )
      )
    );
  }

  Widget mainScreen() {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          children: <Widget>[
            Text(widget.title),
          ],
        )

      ),
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        color: widget.backgroundColor,
        child: Scrollbar(
          child: GridView(
            controller: scrollController,
            children: pokemons, 
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3)
          )
        )
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: fetchPokemons,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  Widget build(BuildContext context) {
    if(pokemons[0] is Text){
      fetchPokemons(21);
      return loadingScreen();
    }else {
      return mainScreen();
    }
  }
}