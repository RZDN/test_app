import 'package:flutter/cupertino.dart';
import 'package:test_app/model/pokemon_detail.dart';
import 'package:test_app/service/sql/local_data.dart';

class FavoriteProvider with ChangeNotifier {
  LocalData localData = LocalData();
  List<PokemonDetail> _listFavorites = [];

  List<PokemonDetail> get listFavorites => _listFavorites;

  Future<void> addFavorite(PokemonDetail pokemonDetail) async {
    await localData.savePokemon(pokemonDetail);
    _listFavorites = await localData.getListPokemons();
    notifyListeners();
  }

  Future<void> deleteFavorite(int id) async {
    await localData.deletePokemon(id);
    _listFavorites = await localData.getListPokemons();
    notifyListeners();
  }

  Future<void> chargeData() async {
    _listFavorites = await localData.getListPokemons();
    notifyListeners();
  }

  bool isFavorite(int id) {
    for (int i = 0; i < _listFavorites.length; i++) {
      if (listFavorites[i].id == id) {
        return true;
      }
    }

    return false;
  }

  Future<void> clearDataBase() async {
    _listFavorites = [];
    await localData.deleteDataBase();
    notifyListeners();
  }
}
