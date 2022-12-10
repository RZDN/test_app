import 'dart:convert';

import 'package:http/http.dart';
import 'package:test_app/model/pokemon_detail.dart';

class PokemonDetailService {
  Future<PokemonDetail> getPokemonById(String url) async {
    final response = await get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      return PokemonDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Call Failed");
    }
  }
}
