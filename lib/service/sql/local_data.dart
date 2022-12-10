import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_app/model/pokemon_detail.dart';
import 'package:test_app/model/stats.dart';

class LocalData {
  static Future<Database> openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'pokemon.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE pokemon (id INTEGER PRIMARY KEY, base_experience INTEGER , height INTEGER, name TEXT, n_order INTEGER, weight INTEGER,front_default TEXT)",
        );
        await db.execute(
            "CREATE TABLE stat (id INTEGER PRIMARY KEY AUTOINCREMENT, pokemon_id INTEGER, base_stat INTEGER, effort INTEGER,name TEXT)");
      },
      version: 1,
    );
  }

  Future<List<PokemonDetail>> getListPokemons() async {
    Database database = await openDB();

    final response = await database.query("pokemon");
    final List<Map<String, dynamic>> maps = response;

    List<PokemonDetail> list = [];

    for (int i = 0; i < maps.length; i++) {
      List<Stat> stats = await getAllStatsByPokemonID(maps[i]["id"]);
      list.add(PokemonDetail(
        maps[i]["id"],
        maps[i]["base_experience"],
        maps[i]["height"],
        maps[i]["name"],
        maps[i]["n_order"],
        maps[i]["weight"],
        maps[i]["front_default"],
        stats,
      ));
    }
    return list;
  }

  Future<void> savePokemon(PokemonDetail pokemonDetail) async {
    Database database = await openDB();

    final response = await get(Uri.parse(pokemonDetail.frontDefault));

    final image = base64Encode(response.bodyBytes);

    await database.insert("pokemon", pokemonDetail.toLocalDb(image));

    for (int i = 0; i < pokemonDetail.stats.length; i++) {
      await database.insert(
          "stat", pokemonDetail.stats[i].toLocalDb(pokemonDetail.id));
    }
  }

  Future<List<Stat>> getAllStatsByPokemonID(int pokemonId) async {
    Database database = await openDB();
    final response = await database
        .query("stat", where: "pokemon_id = ?", whereArgs: [pokemonId]);
    final List<Map<String, dynamic>> maps = response;

    return List.generate(maps.length, (i) {
      return Stat(
        maps[i]['base_stat'],
        maps[i]["effort"],
        maps[i]["name"],
      );
    });
  }

  Future<void> deletePokemon(int id) async {
    Database database = await openDB();
    await database.delete(
      "pokemon",
      where: "id = ?",
      whereArgs: [id],
    );
    await database.delete(
      "stat",
      where: "pokemon_id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteDataBase() async {
    databaseFactory.deleteDatabase(
      join(await getDatabasesPath(), 'pokemon.db'),
    );
  }
}
