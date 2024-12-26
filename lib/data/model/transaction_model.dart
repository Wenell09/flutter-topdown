class TransactionModel {
  final String transactionId,
      userId,
      username,
      email,
      itemId,
      itemName,
      productName,
      productImage,
      productCategory,
      transactionTarget,
      payment,
      status,
      createdAt;
  final int itemPrice, payMoney, moneyChange;

  TransactionModel({
    required this.transactionId,
    required this.userId,
    required this.username,
    required this.email,
    required this.itemId,
    required this.itemName,
    required this.itemPrice,
    required this.productName,
    required this.productImage,
    required this.productCategory,
    required this.transactionTarget,
    required this.payMoney,
    required this.moneyChange,
    required this.payment,
    required this.status,
    required this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionId: json['transaction_id'] ?? "",
      userId: json["user_id"] ?? "",
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      itemId: json["item_id"] ?? "",
      itemName: json['item_name'] ?? "",
      itemPrice: json['item_price'] ?? 0,
      productName: json['product_name'] ?? "",
      productImage: json['product_image'] ?? "",
      productCategory: json['product_category'] ?? "",
      transactionTarget: json['transaction_target'] ?? "",
      payMoney: json['pay_money'] ?? 0,
      moneyChange: json['money_change'] ?? 0,
      payment: json['payment'] ?? "",
      status: json['status'] ?? "",
      createdAt: json['created_at'] ?? "",
    );
  }
}
