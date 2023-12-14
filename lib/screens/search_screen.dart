import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vair_app/helpers/api_endpoints.dart';
import 'search_result_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();

  Future<List<dynamic>> _searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndPoints.productEndPoints.search(query)),
      );

      if (response.statusCode == 200) {
        print(json.decode(response.body)['data']);

        return json.decode(response.body)['data'];
      } else {
        // Handle error
        print('Failed to load products');
        return [];
      }
    } catch (error) {
      // Handle network error
      print('Network error: $error');
      return [];
    }
  }

  void _searchAndNavigate() async {
    String query = _searchController.text;
    if (query.isNotEmpty) {
      List<dynamic> searchResults = await _searchProducts(query);
      Get.to(() => SearchResultScreen(searchResults));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Products',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchAndNavigate,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
