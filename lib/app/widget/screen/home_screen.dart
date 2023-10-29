import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final double price;

  Product(this.name, this.description, this.price);
}

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
    return Scaffold(
        body: Column(
      children: [
        Container(
            height: 200,
            child: Column(
              children: [
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Featured & Recommended',
                      ),
                    )
                  ],
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(products.length, (index) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Container(
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(Icons.shopping_cart),
                              Text(products[index].name),
                              Text(products[index].description),
                              Text(
                                  '\$${products[index].price.toStringAsFixed(2)}'),
                            ],
                          ),
                        ),
                      );
                    }))),
              ],
            )),
        Expanded(
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: Text(products[index].name),
                  subtitle: Text(products[index].description),
                  trailing:
                      Text('\$${products[index].price.toStringAsFixed(2)}'),
                ),
              );
            },
          ),
        )
      ],
    ));
  }
}
