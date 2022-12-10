import 'package:flutter/material.dart';
import 'package:test_app/model/pokemon_detail.dart';
import 'package:test_app/view/widgets/pokemon_card_widget.dart';

class PokemonDetailPage extends StatefulWidget {
  final PokemonDetail pokemonDetail;
  const PokemonDetailPage({super.key, required this.pokemonDetail});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemon Detail"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: PokemonCardWidget(
            pokemonDetail: widget.pokemonDetail,
          )),
    );
  }
}
