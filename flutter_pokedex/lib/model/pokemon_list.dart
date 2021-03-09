import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/model/pokedex.dart';
import 'package:flutter_pokedex/model/pokemon_detay.dart';
import 'package:http/http.dart' as http;

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      ("https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"); //verileri vurdan çekicez
  Pokedex pokedex;
  Future<Pokedex> veri;

  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(url);
    var decodedJson = jsonDecode(response.body);
    pokedex = Pokedex.fromJson(decodedJson);
    return pokedex;
  }

  @override
  void initState() {
    //initState ilk açtığımızda tetiklenir.Onndan sonra başka tetiklenmez.
    // TODO: implement initState
    super.initState();
    veri =
        pokemonlariGetir(); //uygulama çalışırken bir kez doldurulacak. Sonrasında build tekrar tekrar çalışsa bile sürekli olarak burası tetiklenir (her seferinde internete çıkmıcaz direkt olarak bu değişkeni kullanıcaz)
  }

  @override
  Widget build(BuildContext context) {
    //build tekrar tekrar çalışır
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: OrientationBuilder(
          // ignore: missing_return
          builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return FutureBuilder(
              future: veri,
              builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
                if (gelenPokedex.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (gelenPokedex.connectionState ==
                    ConnectionState.done) {
                  /* return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Text(gelenPokedex.data.pokemon[index].name);
                      });*/
                  return GridView.count(
                    crossAxisCount: 2,
                    children: gelenPokedex.data.pokemon.map((poke) {
                      return InkWell(
                        //tıklanma özelliği veriyoruz.
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PokemonDetail(
                                    pokemon: poke,
                                  )));
                        },
                        child: Hero(
                          tag: poke.img,
                          child: Card(
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 120,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/loading.gif",
                                      image: poke.img,
                                      fit: BoxFit.contain,
                                    ), //resim yüklenene kadar placeolder resmi yada gifti kullanmamızı sağlıyor.Daha sonra da resmin kendisini veriyoruz.
                                  ),
                                ),
                                Text(
                                  poke.name,
                                  style: TextStyle(
                                      fontSize: 21,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
                return Container();
              });
        } else {
          return FutureBuilder(
              future: veri,
              builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
                if (gelenPokedex.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (gelenPokedex.connectionState ==
                    ConnectionState.done) {
                  /* return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Text(gelenPokedex.data.pokemon[index].name);
                      });*/
                  return GridView.extent(
                    maxCrossAxisExtent: 300,
                    children: gelenPokedex.data.pokemon.map((poke) {
                      return InkWell(
                        //tıklanma özelliği veriyoruz.
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PokemonDetail(
                                    pokemon: poke,
                                  )));
                        },
                        child: Hero(
                          tag: poke.img,
                          child: Card(
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 200,
                                    height: 150,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/loading.gif",
                                      image: poke.img,
                                      fit: BoxFit.contain,
                                    ), //resim yüklenene kadar placeolder resmi yada gifti kullanmamızı sağlıyor.Daha sonra da resmin kendisini veriyoruz.
                                  ),
                                ),
                                Text(
                                  poke.name,
                                  style: TextStyle(
                                      fontSize: 21,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
                return Container();
              });
        }
      }),
    );
  }
}
