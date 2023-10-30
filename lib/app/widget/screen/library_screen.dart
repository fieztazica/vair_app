import 'package:flutter/material.dart';
import 'package:vair_app/app/widget/card/product_card.dart';

List<Product> products = [
  Product('Product 1', 'Description for Product 1', 10.99),
  Product('Product 2', 'Description for Product 2', 15.99),
  Product('Product 3', 'Description for Product 3', 8.99),
  Product('Product 4', 'Description for Product 4', 7.99),
  Product('Product 5', 'Description for Product 5', 1.99),
  Product('Product 1', 'Description for Product 1', 10.99),
  Product('Product 2', 'Description for Product 2', 15.99),
  Product('Product 3', 'Description for Product 3', 8.99),
  Product('Product 4', 'Description for Product 4', 7.99),
  Product('Product 5', 'Description for Product 5', 1.99),
  Product('Product 1', 'Description for Product 1', 10.99),
  Product('Product 2', 'Description for Product 2', 15.99),
  Product('Product 3', 'Description for Product 3', 8.99),
  Product('Product 4', 'Description for Product 4', 7.99),
  Product('Product 5', 'Description for Product 5', 1.99),
];

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: Container(
            color: Colors.blue,
            child: Center(
              child: Text(
                'Bought ${products[index].name}',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
