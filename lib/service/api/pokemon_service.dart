import 'dart:convert';

import 'package:http/http.dart';
import 'package:test_app/model/pokemon.dart';

class PokemonService {
  Future<List<Pokemon>> getListPokemons() async {
    List<Pokemon> lista = [];
    try {
      final response = await get(
        Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=100&offset=0"),
      );

      if (response.statusCode == 200) {
        final parsed =
            jsonDecode(response.body)["results"].cast<Map<String, dynamic>>();

        lista = parsed.map<Pokemon>((json) => Pokemon.fromJson(json)).toList();
        return lista;
      }
    } catch (err) {
      Exception(err);
    }
    return lista;
  }
}
