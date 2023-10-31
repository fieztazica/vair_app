import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/app/screen/home_screen.dart';
import 'package:vair_app/app/widget/product_card.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Product prod =
        products.where((element) => element.name == Get.parameters['id']).first;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
        title: Text(prod.name),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.search))
        ],
      ),
      body: ListView(children: [
        Text(prod.name),
        Text(prod.description),
        Text(prod.price.toString())
      ]),
    );
  }
}
