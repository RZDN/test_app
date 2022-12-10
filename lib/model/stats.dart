class Stat {
  final int _baseStat;
  final int _effort;
  final String _name;

  Stat(
    this._baseStat,
    this._effort,
    this._name,
  );

  int get baseStat => _baseStat;
  int get effort => _effort;
  String get name => _name;

  factory Stat.fromjson(Map<String, dynamic> json) {
    return Stat(
      json["base_stat"],
      json["effort"],
      json["stat"]["name"],
    );
  }

  Map<String, dynamic> toLocalDb(int pokemonId) {
    return {
      "pokemon_id": pokemonId,
      "base_stat": baseStat,
      "effort": effort,
      "name": name,
    };
  }
}
