import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/models/Product.dart';
import 'package:vair_app/shared/const_data.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String productId = Get.parameters['id'] ?? "";

    Product prod = exampleProducts.firstWhere(
      (element) => element.name == productId,
      orElse: () => Product(
        name: 'Product Not Found',
        description: 'Description Not Available',
        price: 0.0,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(prod.name!),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (prod.logo != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      prod.logo!.url!,
                      height: 80, // Adjust the height as needed
                      width: 80, // Adjust the width as needed
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 16,
                    ), // Add spacing between image and name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text('Name'),
                            subtitle: Text(prod.name!),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(
                        double.infinity, 30)), // Adjust the height as needed
                  ),
                  child: Text(
                    prod.price! <= 0
                        ? 'Install'
                        : '${prod.price?.toStringAsFixed(2)} VND',
                  ),
                ),
              ),
              if (prod.banners != null && prod.banners!.isNotEmpty)
                Container(
                  height: 200,
                  child: PageView.builder(
                    itemCount: prod.banners!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.0),
                        child: Image.network(
                          prod.banners![index].url!,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('Description'),
                subtitle: Text(prod.description!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
