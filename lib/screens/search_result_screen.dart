import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/models/Product.dart';
import 'package:vair_app/routes/app_pages.dart';

class SearchResultScreen extends StatelessWidget {
  final List<dynamic> searchResults;

  SearchResultScreen(this.searchResults);

  void _navigateToProductDetail(int productId) {
    Get.toNamed(Routes.DETAIL, parameters: {"id": productId.toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: ListView.builder(
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
      ),
    );
  }
}
