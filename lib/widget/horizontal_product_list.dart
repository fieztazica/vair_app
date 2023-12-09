import 'package:flutter/material.dart';
import 'package:vair_app/widget/product_card.dart';
import 'package:vair_app/widget/list_title.dart';
import 'package:vair_app/models/Product.dart';

class HorizontalProductList extends StatelessWidget {
  final String title;
  final List<Product> items;

  const HorizontalProductList(
      {super.key, required this.items, required this.title});

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
                  logoUrl:
                      "${items[index].logo?.uri}" ?? '', // Handle null case
                  bannerUrl: items[index].banners?.first?.uri.toString() ??
                      'https://cdn.discordapp.com/attachments/1158760585027133450/1180429985266282567/image.png?ex=657d6417&is=656aef17&hm=1e1df53c211838d7b640eb6a43a94549cf7f40c894aeafca01a40c52bb57d72e&', // Handle null case
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
