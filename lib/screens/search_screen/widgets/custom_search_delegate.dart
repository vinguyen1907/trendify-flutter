import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSearchDelegate extends SearchDelegate {
  final sharedPreferences = GetIt.I.get<SharedPreferences>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  void showResults(BuildContext context) {
    Navigator.of(context).pushNamed(
      SearchScreen.routeName,
      arguments: query,
    );
    List<String>? currentHistories = sharedPreferences.getStringList(SharedPreferencesKeys.searchHistories);
    currentHistories ??= [];
    if (currentHistories.contains(query)) {
      currentHistories.remove(query);
    }
    currentHistories.insert(0, query);
    sharedPreferences.setStringList(SharedPreferencesKeys.searchHistories, currentHistories);
    super.showResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _suggestion(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final suggestion = snapshot.data![index];
            return ListTile(
              title: Text(suggestion),
              onTap: () {
                query = suggestion;
                showResults(context);
              },
            );
          },
        );
      },
    );
  }

  Future<List<String>> _suggestion() async {
    final List<String> listSuggestion = sharedPreferences.getStringList(SharedPreferencesKeys.searchHistories) ?? [];
    // final List<Product> products = await ProductRepository().fetchAllProducts();
    // final List<String> temp = products.map((e) => e.name).toList();
    // final List<String> listSuggestion = temp.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();
    return listSuggestion;
  }
}
