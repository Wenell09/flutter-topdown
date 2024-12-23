class ProductModel {
  final String productId, name, categoryId, category, image, createdAt;

  ProductModel({
    required this.productId,
    required this.name,
    required this.categoryId,
    required this.category,
    required this.image,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json["product_id"] ?? "",
      name: json["name"] ?? "",
      categoryId: json["category_id"] ?? "",
      category: json["category"] ?? "",
      image: json["image"] ?? "",
      createdAt: json["created_at"] ?? "",
    );
  }
}
