import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vair_app/helpers/api_endpoints.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

  Future<void> _searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndPoints.productEndPoints.search(query)),
      );

      if (response.statusCode == 200) {
        setState(() {
          searchResults = json.decode(response.body)['data'];
        });
      } else {
        // Handle error
        print('Failed to load products');
      }
    } catch (error) {
      // Handle network error
      print('Network error: $error');
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
                  onPressed: () {
                    String query = _searchController.text;
                    if (query.isNotEmpty) {
                      _searchProducts(query);
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                // Display your product information here
                return ListTile(
                  title: Text(searchResults[index]['name']),
                  subtitle: Text('Price: \$${searchResults[index]['price']}'),
                  // Add more information as needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
