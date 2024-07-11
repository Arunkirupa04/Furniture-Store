class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String brand;
  final int stock;
  final double ratings;
  final int numReviews;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.brand,
    required this.stock,
    required this.ratings,
    required this.numReviews,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'],
      brand: json['brand'],
      stock: json['stock'],
      ratings: json['ratings'].toDouble(),
      numReviews: json['numReviews'],
      images: List<String>.from(json['images'].map((x) => x['url'])),
    );
  }

  get company => null;

  get imageUrl => null;
}
