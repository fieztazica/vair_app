import 'package:flutter/material.dart';
import 'package:vair_app/app/widget/product_card.dart';
import 'package:vair_app/app/widget/horizontal_product_list.dart';
import 'package:vair_app/app/widget/list_title.dart';

List<Product> products = [
  Product('Product 1', 'Description for Product 1', 10.99),
  Product('Product 2', 'Description for Product 2', 15.99),
  Product('Product 3', 'Description for Product 3', 8.99),
  Product('Product 4', 'Description for Product 4', 7.99),
  Product('Product 5', 'Description for Product 5', 1.99),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HorizontalProductList(items: products, title: "Featured & Recommended"),
        HorizontalProductList(items: products, title: 'Suggested'),
        HorizontalProductList(items: products, title: 'Actions'),
        HorizontalProductList(items: products, title: 'Indie games'),
      ],
    );
  }
}
