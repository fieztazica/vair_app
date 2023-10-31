import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(
            width: 300,
            height: 40,
            child: SearchBar(hintText: 'Search something...')),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  return;
                },
                icon: const Icon(Icons.mic)),
          )
        ],
      ),
      body: ListView(),
    );
  }
}
