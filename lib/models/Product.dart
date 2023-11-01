class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String logoUrl;
  final List<String> bannerUrls;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      this.price = 0,
      required this.logoUrl,
      required this.bannerUrls});
}
