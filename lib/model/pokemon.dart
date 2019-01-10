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
}