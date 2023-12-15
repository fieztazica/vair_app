import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:vair_app/helpers/api_endpoints.dart';
import 'package:vair_app/models/Category.dart';
import 'package:vair_app/models/Product.dart';

class HomeTabController extends GetxController with StateMixin<List<Product>> {
  Rxn<List<Product>> products = Rxn();
  RxList<Widget> categories = <Widget>[].obs;
  Rx<String> selectedCategory = Rx("All");

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.empty());
    getCategories();
    getData();
  }

  void getData({String category = ""}) async {
    try {
      change(null, status: RxStatus.loading());

      var query = category.isEmpty ? "" : "?category=${category}";

      var res = await get(Uri.parse(
          "${ApiEndPoints.expressBaseApiURL}/${ApiEndPoints.productEndPoints.base()}$query"));

      // print("API Response: ${res.statusCode} - ${res.body}");

      if (res.statusCode == 200 && res.body != null) {
        var responseBody = json.decode(res.body);

        if (responseBody['data'] is List) {
          List<Product> products = List<Product>.from(
            (responseBody['data'] as List)
                .map((dynamic item) => Product.fromJson(item)),
          );
          change(products, status: RxStatus.success());
          this.products.value = products;
        } else {
          // Handle the case when the "data" field is not a list
          throw "Invalid response format: ${res.body}";
        }
      } else {
        print("API Response: ${res?.statusCode} - ${res?.body}");
        throw "API Response Failed: ${res.body}";
      }
    } catch (e) {
      print("Error in getData: $e");
      change(null, status: RxStatus.error("$e"));
    }
  }

  void getCategories() async {
    try {
      var res =
          await get(Uri.parse("${ApiEndPoints.expressBaseApiURL}/categories"));

      // print("API Response: ${res.statusCode} - ${res.body}");

      if (res.statusCode == 200 && res.body != null) {
        var responseBody = json.decode(res.body);

        if (responseBody['data'] is List) {
          List<Category> categories = List<Category>.from(
            (responseBody['data'] as List)
                .map((dynamic item) => Category.fromJson(item)),
          );
          this.categories.value = renderCategoryButtons(categories);
        } else {
          // Handle the case when the "data" field is not a list
          throw "Invalid response format: ${res.body}";
        }
      } else {
        print("API Response: ${res?.statusCode} - ${res?.body}");
        throw "API Response Failed: ${res.body}";
      }
    } catch (e) {
      print("Error in getData: $e");
    }
  }

  List<Widget> renderCategoryButtons(List<Category> categories) {
    categories = [Category(name: "All"), ...categories];
    return categories
        .map(
          (e) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: OutlinedButton(
                  onPressed: () {
                    selectedCategory.value = e.name!;
                    getData(category: e.name!);
                  },
                  child: Text("${e.name}"))),
        )
        .toList();
  }

  Future<void> refreshData() async {
    getData();
    getCategories();
  }

  void onClose() {
    super.onClose();
    change(null, status: RxStatus.empty());
  }
}
