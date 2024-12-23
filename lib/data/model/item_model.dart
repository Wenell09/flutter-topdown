class ItemModel {
  final String itemId, name, image, productName, productImage, category;
  final int price;
  ItemModel({
    required this.itemId,
    required this.name,
    required this.image,
    required this.productName,
    required this.productImage,
    required this.category,
    required this.price,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      itemId: json["item_id"] ?? "",
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      productName: json["product_name"] ?? "",
      productImage: json["product_image"] ?? "",
      category: json["category"] ?? "",
      price: json["price"] ?? 0,
    );
  }
}
