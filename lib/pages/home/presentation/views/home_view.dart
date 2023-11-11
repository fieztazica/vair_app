import 'package:flutter/material.dart';
import 'package:vair_app/widget/horizontal_product_list.dart';
import 'package:vair_app/shared/const_data.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HorizontalProductList(
            items: exampleProducts, title: "Featured & Recommended"),
        HorizontalProductList(items: exampleProducts, title: 'Suggested'),
        HorizontalProductList(items: exampleProducts, title: 'Actions'),
        HorizontalProductList(items: exampleProducts, title: 'Indie games'),
      ],
    );
  }
}
