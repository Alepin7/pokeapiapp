import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test/screen/pokemon.dart';

class Pokedex extends StatefulWidget {
  const Pokedex({super.key, required this.jwt});
  final String jwt;

  @override
  State<Pokedex> createState() => _Pokedex();
}

class _Pokedex extends State<Pokedex> {
  int currentPage = 1;
  int totalPages = 1;
  int chunk = 20;

  // Esta es la función que obtiene el listado de pokemon
  Future<List<dynamic>> getPokemonList(int limit, int offset) async {
    // La URL de la Poke API que devuelve un listado de pokemon
    Uri url = Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset');

    // Hacemos una solicitud HTTP GET a la URL
    var response = await http.get(url);

    // Verificamos que la respuesta fue exitosa
    if (response.statusCode == 200) {
      // Decodificamos la respuesta JSON
      var data = jsonDecode(response.body);

      // Obtenemos el listado de pokemon del JSON
      var pokemonList = data['results'];
      return pokemonList;
    } else {
      // Si hay un error, lanzamos una excepción
      throw Exception('Error al obtener la lista de pokemon 1');
    }
  }

  void _loadNextpage() {
    setState(() {
      currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: FutureBuilder(
        future: getPokemonList(chunk, 0),
        builder: (context, snapshot) {
          final pokemons = snapshot.data ?? [];
          totalPages = (pokemons.length / 20).ceil();
          final itemCount = pokemons.length;
          return Center(
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                var pokemon = pokemons[index] ?? {};
                return ListTile(
                  leading: const Icon(Icons.catching_pokemon),
                  trailing: const Text(
                    "Paralela",
                    style: TextStyle(
                      color: Color.fromARGB(255, 19, 15, 5),
                      fontSize: 15,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pokemon(
                            name: pokemon["name"],
                            url: pokemon["url"],
                            jwt: widget.jwt,
                          ),
                        ));
                  },
                  title: Text(pokemon["name"]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
