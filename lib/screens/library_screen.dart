import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vair_app/models/Product.dart';
import 'package:vair_app/shared/const_data.dart';

List<Product> products = [
  ...exampleProducts,
  ...exampleProducts,
  ...exampleProducts
];

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        var selectedProduct = products[index];

        return GridTile(
          header: Container(
            padding: const EdgeInsets.all(5),
            color: Colors.teal[900]?.withOpacity(0.8),
            child: Text(
              selectedProduct.name!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
          footer: Container(
            padding: const EdgeInsets.all(5),
            color: Colors.teal[900]?.withOpacity(0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Installed",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white),
                )
              ],
            ),
          ),
          child: Container(
            color: Colors.teal[300],
            child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: selectedProduct.logo!.url!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error)),
          ),
        );
      },
    );
  }
}
