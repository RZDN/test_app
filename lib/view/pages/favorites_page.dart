import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/service/favorites_provider.dart';
import 'package:test_app/view/widgets/pokemon_card_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return favoriteProvider.listFavorites.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              leading: Container(),
              title: const Text("Favorites"),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: favoriteProvider.listFavorites.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: PokemonCardWidget(
                    pokemonDetail: favoriteProvider.listFavorites[index],
                    isFavoritePage: true,
                  ),
                );
              }),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await favoriteProvider.clearDataBase();
              },
              child: const Center(
                child: Icon(
                  Icons.delete,
                  size: 35,
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: Container(),
              title: const Text("Favorites"),
              centerTitle: true,
            ),
            body: const Center(
                child: Text(
              "You don't have favorites",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            )),
          );
  }
}
