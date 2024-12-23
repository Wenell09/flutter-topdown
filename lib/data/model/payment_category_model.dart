class PaymentCategoryModel {
  final String paymentCategoryId, name;
  PaymentCategoryModel({required this.paymentCategoryId, required this.name});

  factory PaymentCategoryModel.fromJson(Map<String, dynamic> json) {
    return PaymentCategoryModel(
      paymentCategoryId: json["payment_category_id"] ?? "",
      name: json["name"] ?? "",
    );
  }
}
