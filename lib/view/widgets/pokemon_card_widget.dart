import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/model/pokemon_detail.dart';
import 'package:test_app/service/favorites_provider.dart';

class PokemonCardWidget extends StatelessWidget {
  final bool isFavoritePage;
  final PokemonDetail pokemonDetail;
  const PokemonCardWidget(
      {super.key, required this.pokemonDetail, this.isFavoritePage = false});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          height: 450.0,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Text(
                pokemonDetail.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: isFavoritePage
                      ? Image.memory(base64Decode(pokemonDetail.frontDefault))
                      : Image.network(pokemonDetail.frontDefault.toString()),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(pokemonDetail.baseExperience.toString()),
                            const Text("experience"),
                          ],
                        ),
                        Column(
                          children: [
                            Text(pokemonDetail.height.toString()),
                            const Text("height"),
                          ],
                        ),
                        Column(
                          children: [
                            Text(pokemonDetail.weight.toString()),
                            const Text("weight"),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Expanded(
                        child: GridView.builder(
                            physics:
                                const ScrollPhysics(parent: ScrollPhysics()),
                            shrinkWrap: true,
                            itemCount: pokemonDetail.stats.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 80,
                              crossAxisCount: 3,
                            ),
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(2, 2),
                                          color: Colors.black12,
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                        )
                                      ]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(pokemonDetail.stats[index].baseStat
                                          .toString()),
                                      Text(
                                        pokemonDetail.stats[index].name,
                                        style: const TextStyle(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }))),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10.0,
          right: 15.0,
          child: favoriteProvider.isFavorite(pokemonDetail.id)
              ? InkWell(
                  onTap: () async {
                    await favoriteProvider.deleteFavorite(pokemonDetail.id);
                  },
                  child: const Icon(
                    Icons.favorite_sharp,
                    color: Colors.red,
                    size: 50.0,
                  ),
                )
              : InkWell(
                  onTap: () async {
                    await favoriteProvider.addFavorite(pokemonDetail);
                    //await favoriteProvider.clearTable();
                  },
                  child: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.black,
                    size: 50.0,
                  ),
                ),
        ),
      ],
    );
  }
}
