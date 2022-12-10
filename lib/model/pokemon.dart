class Pokemon {
  final String _name;
  final String _url;

  Pokemon(this._name, this._url);

  String get name => _name;
  String get url => _url;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      json["name"],
      json["url"],
    );
  }
}
