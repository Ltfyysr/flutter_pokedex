import 'package:flutter/material.dart';
import 'package:flutter_pokedex/model/pokemon_list.dart';

//import 'model/pokemon_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: PokemonList(),
    );
  }
}
