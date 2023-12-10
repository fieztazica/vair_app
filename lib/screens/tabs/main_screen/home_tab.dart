import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/home_tab_controller.dart';
import 'package:vair_app/widget/horizontal_product_list.dart';
import 'package:vair_app/models/Product.dart';

class HomeTab extends StatelessWidget {
  final HomeTabController _homeTabController = Get.put(HomeTabController());

  HomeTab({Key? key}) : super(key: key);

  Future<void> _refresh() async {
    await _homeTabController.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refresh,
        child: _homeTabController.obx(
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
        ));
  }

  Widget _buildProductLists(List<Product> products) {
    List<Product> shuffledProducts1 = List.from(products)..shuffle();
    List<Product> shuffledProducts2 = List.from(products)..shuffle();
    List<Product> shuffledProducts3 = List.from(products)..shuffle();
    List<Product> shuffledProducts4 = List.from(products)..shuffle();
    return ListView(
      children: [
        HorizontalProductList(
          items: shuffledProducts1,
          title: "Featured & Recommended",
        ),
        HorizontalProductList(
          items: shuffledProducts2,
          title: 'Suggested',
        ),
        HorizontalProductList(
          items: shuffledProducts3,
          title: 'Actions',
        ),
        HorizontalProductList(
          items: shuffledProducts4,
          title: 'Indie games',
        ),
      ],
    );
  }
}
