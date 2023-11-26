import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/home_tab_controller.dart';
import 'package:vair_app/widget/horizontal_product_list.dart';
import 'package:vair_app/shared/const_data.dart';

class HomeTab extends StatelessWidget {
  final HomeTabController controller = Get.put(HomeTabController());

  HomeTab({super.key});

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
