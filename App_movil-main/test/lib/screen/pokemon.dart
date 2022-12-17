import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../service/firebase_services.dart';

typedef Accessor = Widget? Function(dynamic data);

class Pokemon extends StatefulWidget {
  final String name;
  final String url;
  final String jwt;

  const Pokemon(
      {super.key, required this.name, required this.url, required this.jwt});

  @override
  State<Pokemon> createState() => _PokemonState();
}

class _PokemonState extends State<Pokemon> {
  Future<dynamic> getPokemon(String url) async {
    // La URL de la Poke API que devuelve un listado de pokemon

    Uri poke = Uri.parse(url);

    // Hacemos una solicitud HTTP GET a la URL
    var response = await http.get(poke);

    // Verificamos que la respuesta fue exitosa
    if (response.statusCode == 200) {
      // Decodificamos la respuesta JSON
      var data = jsonDecode(response.body);

      // Obtenemos el listado de pokemon del JSON
      return data;
    } else {
      // Si hay un error, lanzamos una excepción
      throw Exception('Error al obtener pokemon ');
    }
  }

  Future<Map<String, dynamic>?> getLocation(url) async {
    Uri location = Uri.parse(url);
    var response = await http.get(location);
    if (response.statusCode == 200) {
      // Decodificamos la respuesta JSON
      var data = jsonDecode(response.body);

      // Obtenemos el listado de pokemon del JSON
      return data?.length > 0 ? (data[0] as Map<String, dynamic>) : null;
    } else {
      // Si hay un error, lanzamos una excepción
      throw Exception('Error al obtener locación ');
    }
  }

  Map<String, Accessor> get headers => {
        "ID": (data) => Text(data["id"].toString()),
        "Altura": (data) => Text("${data["height"] / 10} m"),
        "Peso": (data) => Text("${data["weight"] / 10} kg"),
        "Habilidades": (data) => Text(
              (data["abilities"] as List<dynamic>).fold<List<dynamic>>(
                [],
                (acc, e) => [...acc, e["ability"]["name"]],
              ).join(", "),
            ),
        "Tipos": (data) => Text(
              (data["types"] as List<dynamic>).fold<List<dynamic>>(
                [],
                (acc, e) => [...acc, e["type"]["name"]],
              ).join(", "),
            ),
        "Ubicación": (data) => FutureBuilder(
              future: getLocation(data["location_area_encounters"]),
              builder: (context, snapshot) {
                final location = snapshot.data;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LinearProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text("Ha ocurrido un error");
                }

                return Text(
                  location?["location_area"]["name"] ??
                      "No se encuentra salvaje",
                );
              },
            ),
      };

  @override
  Widget build(BuildContext context) {
    const mail = 't27rEkz1y82MKE4pHHZl';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: FutureBuilder(
        future: getPokemon(widget.url),
        builder: (context, snapshot) {
          var pokemon = snapshot.data;
          if (snapshot.hasData) {
            return StreamBuilder<Json>(
              stream: getUser(mail),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error');
                }

                final user = snapshot.data;
                final pokemonName = pokemon["name"] as String;
                final favorites = user?["favorito"] as List?;
                final canFavorite = favorites != null && favorites.length < 3;
                final isFavorite = favorites?.contains(pokemonName) ?? false;

                return ListView(
                  children: [
                    Center(
                      child: Image.network(
                        pokemon["sprites"]["front_default"],
                        scale: 0.5,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextButton(
                        onPressed: canFavorite || isFavorite
                            ? () async {
                                if (isFavorite) {
                                  await removePokemonV(pokemonName);
                                  await removeUserV(mail, pokemonName);
                                } else {
                                  await addPokemonV(pokemonName);
                                  await addUserV(mail, pokemonName);
                                }
                              }
                            : null,
                        child: Text(isFavorite
                            ? 'Quitar de favoritos (${favorites?.length})'
                            : 'Añadir a favoritos (${favorites?.length})'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: DataTable(
                        columns: const [
                          DataColumn(
                            label: Text("Atributos"),
                          ),
                          DataColumn(
                            label: Text("Valor"),
                          ),
                        ],
                        rows: [
                          for (final header in headers.entries)
                            DataRow(
                              cells: [
                                DataCell(Text(header.key)),
                                DataCell(
                                  header.value(pokemon) ??
                                      const Text("No especificado"),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
