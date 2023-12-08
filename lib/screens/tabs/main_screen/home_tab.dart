import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/home_tab_controller.dart';
import 'package:vair_app/widget/horizontal_product_list.dart';
import 'package:vair_app/models/Product.dart';

class HomeTab extends StatelessWidget {
  final HomeTabController _homeTabController = Get.put(HomeTabController());

  HomeTab({Key? key});

  @override
  Widget build(BuildContext context) {
    return _homeTabController.obx(
      (state) => _buildProductLists(state!.cast<Product>()),
      onLoading: const Center(
        child: CircularProgressIndicator(),
      ),
      onEmpty: const Center(
        child: Text('No data available'),
      ),
      onError: (error) => Center(
        child: Text('Error: $error'),
      ),
    );
  }

  Widget _buildProductLists(List<Product> products) {
    return ListView(
      children: [
        HorizontalProductList(
          items: products,
          title: "Featured & Recommended",
        ),
        HorizontalProductList(
          items: products,
          title: 'Suggested',
        ),
        HorizontalProductList(
          items: products,
          title: 'Actions',
        ),
        HorizontalProductList(
          items: products,
          title: 'Indie games',
        ),
      ],
    );
  }
}
