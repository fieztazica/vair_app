import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final double price;

  Product(this.name, this.description, this.price);
}

class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final double price;

  const ProductCard(
      {super.key,
      required this.name,
      required this.description,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/details',
            arguments: Product(
                name, description, price)); // Navigate to details screen
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: SizedBox(
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.shopping_cart),
              Text(name),
              Text(description),
              Text('\$${price.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }
}
