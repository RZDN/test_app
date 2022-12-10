import 'package:test_app/model/stats.dart';

class PokemonDetail {
  final int _id;
  final int _baseExperience;
  final int _height;
  final String _name;
  final int _order;
  final int _weight;
  final String _frontDefault;
  final List<Stat> _stats;

  PokemonDetail(this._id, this._baseExperience, this._height, this._name,
      this._order, this._weight, this._frontDefault, this._stats);

  int get id => _id;
  int get baseExperience => _baseExperience;
  int get height => _height;
  String get name => _name;
  int get order => _order;
  int get weight => _weight;
  String get frontDefault => _frontDefault;
  List<Stat> get stats => _stats;

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    List<Stat> stats = [];

    stats = json["stats"].map<Stat>((json) => Stat.fromjson(json)).toList();

    return PokemonDetail(
      json["id"],
      json["base_experience"],
      json["height"],
      json["name"],
      json["order"],
      json["weight"],
      json["sprites"]["other"]["home"]["front_default"],
      stats,
    );
  }

  Map<String, dynamic> toLocalDb(String image) {
    return {
      "id": id,
      "base_experience": baseExperience,
      "height": height,
      "name": name,
      "n_order": order,
      "weight": weight,
      "front_default": image,
    };
  }
}
