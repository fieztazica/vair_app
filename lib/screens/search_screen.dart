import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vair_app/helpers/api_endpoints.dart';
import 'package:vair_app/models/Product.dart';
import 'package:vair_app/routes/app_pages.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

  Future<void> _searchAndNavigate() async {
    String query = _searchController.text;
    if (query.isNotEmpty) {
      List<dynamic> results = await _searchProducts(query);
      setState(() {
        searchResults = results;
      });
    }
  }

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

  void _navigateToProductDetail(int productId) {
    Get.toNamed(Routes.DETAIL, parameters: {"id": productId.toString()});
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
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty) {
      return Center(
        child: Text('No results found'),
      );
    } else {
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          Product product = Product.fromJson(searchResults[index]);
          return GestureDetector(
            onTap: () {
              int productId = product.id!;
              _navigateToProductDetail(productId);
            },
            child: ListTile(
              title: Text(product.name!),
              leading: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: product.logo!.uri.toString(),
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
