import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final String logoUrl;
  final String bannerUrl;
  final bool bought;

  const ProductCard(
      {super.key,
      required this.name,
      required this.description,
      required this.price,
      required this.logoUrl,
      required this.bannerUrl,
      this.bought = false});

  void _onTap() {
    Get.toNamed('/detail', parameters: {"id": name}); //
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.all(10),
        child: InkWell(
            child: Container(
          width: 300,
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 120,
                child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: bannerUrl,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error)),
              ),
              Container(
                width: 300,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: logoUrl,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error)),
                            ),
                          ),
                          Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 110,
                      child: OutlinedButton(
                          onPressed: _onTap,
                          child: price > 0
                              ? Text(
                                  'VND ${price.toStringAsFixed(2)}',
                                  overflow: TextOverflow.ellipsis,
                                )
                              : const Text('Free')),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
