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
                    const SizedBox(
                      width: 4,
                    ), // Add spacing between image and name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(prod.name!),
                            subtitle: const Text("Vair Inc."),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(
                        double.infinity, 35)), // Adjust the height as needed
                  ),
                  child: Text(
                    prod.price! <= 0
                        ? 'Install'
                        : '${prod.price?.toStringAsFixed(2)} VND',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (prod.banners != null && prod.banners!.isNotEmpty)
                Container(
                  height: 200,
                  child: PageView.builder(
                    itemCount: prod.banners!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Image.network(
                          prod.banners![index].url!,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 10),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text('Description'),
                subtitle: Text(prod.description!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
