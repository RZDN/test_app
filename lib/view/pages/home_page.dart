import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/model/pokemon.dart';
import 'package:test_app/model/pokemon_detail.dart';
import 'package:test_app/service/api/pokemon_detail_service.dart';
import 'package:test_app/service/api/pokemon_service.dart';
import 'package:test_app/service/favorites_provider.dart';
import 'package:test_app/view/pages/pokemon_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokemonService pokemonService = PokemonService();
  PokemonDetailService pokemonDetailService = PokemonDetailService();
  List<Pokemon> listPokemon = [];

  Future fetchPokemons() async {
    final data = await pokemonService.getListPokemons();

    if (mounted) {
      setState(() {
        listPokemon = data;
      });
    }
  }

  void pushDetailPage(PokemonDetail data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokemonDetailPage(
          pokemonDetail: data,
        ),
      ),
    );
  }

  @override
  void initState() {
    fetchPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listFavoriteProvider = Provider.of<FavoriteProvider>(context);
    listFavoriteProvider.chargeData();
    return listPokemon.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              leading: Container(),
              title: const Text("Pokemones"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                  itemCount: listPokemon.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () async {
                          final data = await pokemonDetailService
                              .getPokemonById(listPokemon[index].url);

                          pushDetailPage(data);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                listPokemon[index].name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 35,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(
            color: Colors.orange,
          ));
  }
}
