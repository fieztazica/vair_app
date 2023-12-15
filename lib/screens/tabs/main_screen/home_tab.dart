import 'package:cached_network_image/cached_network_image.dart';
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
          (state) => _buildProductLists(
              state!.cast<Product>(),
              _homeTabController.categories,
              _homeTabController.selectedCategory.value),
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

  Widget _buildProductLists(List<Product> products,
      List<Widget> categoriesButtons, String selectedCategory) {
    List<Widget> widgets = [];
    if (selectedCategory == "All") {
      List<Product> shuffledProducts1 = List.from(products)..shuffle();
      List<Product> shuffledProducts2 = List.from(products)..shuffle();
      List<Product> shuffledProducts3 = List.from(products)..shuffle();
      List<Product> shuffledProducts4 = List.from(products)..shuffle();

      widgets = [
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
        )
      ];
    } else {
      print(products.length);
      if (products.isNotEmpty) {
        widgets = products
            .map((e) => ListTile(
                  title: Text(e.name!),
                  subtitle: e.price! > 0
                      ? Text(
                          'VND ${e.price!.toStringAsFixed(2)}',
                          overflow: TextOverflow.ellipsis,
                        )
                      : const Text('Free'),
                  leading: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: e.logo!.uri.toString(),
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ))
            .toList();
      } else {
        widgets = [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text("Nothing found..."),
          )
        ];
      }
    }

    return ListView(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: 40.0,
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[...categoriesButtons],
          ),
        ),
        ...widgets
      ],
    );
  }
}
