import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/product_detail_screen_controller.dart';
import 'package:vair_app/models/Product.dart';
import 'package:vair_app/shared/const_data.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductDetailScreenController _controller =
      Get.find<ProductDetailScreenController>();

  ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: _controller.obx(
          (state) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state!.logo != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.network(
                              state.logo!.url!,
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
                                    title: Text(state.name!),
                                    subtitle: Text(state.subtitle),
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
                                double.infinity,
                                35)), // Adjust the height as needed
                          ),
                          child: Text(state.downloadUrl != null
                              ? state.price! > 0
                                  ? '${state.price?.toStringAsFixed(2)} VND'
                                  : "Install"
                              : "Error"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (state.banners != null && state.banners!.isNotEmpty)
                        Container(
                          height: 200,
                          child: PageView.builder(
                            itemCount: state.banners!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Image.network(
                                  state.banners![index].url!,
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
                        subtitle: Text(state.description!),
                      ),
                    ],
                  ),
                ),
              ),
          onLoading: const Text("Fetching data..."),
          onEmpty: const Text("No data found"),
          onError: (error) => Text(error!)),
    );
  }
}
