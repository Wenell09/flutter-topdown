import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topdown_store/data/constant/base_url.dart';
import 'package:topdown_store/data/model/payment_category_model.dart';

class PaymentCategoryRepo {
  Future<List<PaymentCategoryModel>> getPaymentCategory() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/paymentCategory"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        debugPrint("berhasil get payment category");
        return result
            .map((json) => PaymentCategoryModel.fromJson(json))
            .toList();
      } else {
        debugPrint(response.body);
        return [];
      }
    } catch (e) {
      debugPrint("error payment category:$e");
      return [];
    }
  }
}
