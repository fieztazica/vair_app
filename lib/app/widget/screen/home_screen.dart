import 'package:flutter/material.dart';
import 'package:vair_app/app/widget/card/product_card.dart';
import 'package:vair_app/shared/list_title.dart';

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
        const ListTitle(title: "Featured & Recommended"),
        SizedBox(
            height: 200,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(products.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/details'); // Navigate to details screen
                    },
                    child: ProductCard(
                      name: products[index].name,
                      description: products[index].description,
                      price: products[index].price,
                    ),
                  );
                })))),
        const ListTitle(title: "Suggested"),
        SizedBox(
            height: 200,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(products.length, (index) {
                  return ProductCard(
                    name: products[index].name,
                    description: products[index].description,
                    price: products[index].price,
                  );
                })))),
        const ListTitle(title: "Actions"),
        SizedBox(
            height: 200,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(products.length, (index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.shopping_cart),
                          Text(products[index].name),
                          Text(products[index].description),
                          Text('\$${products[index].price.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  );
                })))),
        const ListTitle(title: "Indie games"),
        SizedBox(
            height: 200,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(products.length, (index) {
                  return ProductCard(
                    name: products[index].name,
                    description: products[index].description,
                    price: products[index].price,
                  );
                })))),
      ],
    );
  }
}
