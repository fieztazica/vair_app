import 'package:flutter/material.dart';
import 'package:vair_app/widget/product_card.dart';
import 'package:vair_app/widget/list_title.dart';
import 'package:vair_app/models/Product.dart';

class HorizontalProductList extends StatelessWidget {
  final String title;
  final List<Product> items;

  const HorizontalProductList(
      {super.key, required this.items, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTitle(title: title),
        SizedBox(
            height: 200,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(items.length, (index) {
                  return ProductCard(
                    id: items[index].id!,
                    name: items[index].name!,
                    description: items[index].description!,
                    price: items[index].price!,
                    logoUrl: items[index].logo!.url!,
                    bannerUrl: items[index].banners!.first.url!,
                  );
                }))))
      ],
    );
  }
}
