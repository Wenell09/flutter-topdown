import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topdown_store/data/constant/base_url.dart';
import 'package:topdown_store/data/model/transaction_model.dart';

class TransactionRepo {
  Future<void> addTransaction(
    String userId,
    String itemId,
    String paymentCategoryId,
    String transactionTarget,
  ) async {
    try {
      final Map<String, dynamic> data = {
        "user_id": userId,
        "admin_id": "411de7ad-044a-4dac-8b38-85616a7ee517",
        "item_id": itemId,
        "payment_category_id": paymentCategoryId,
        "transaction_target": transactionTarget,
        "status": "sedang diproses",
      };
      final response = await http.post(
        Uri.parse("$baseUrl/addTransaction"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);
      } else {
        debugPrint(response.body);
        throw Exception(response.body);
      }
    } catch (e) {
      debugPrint("error add transaction:$e");
      rethrow;
    }
  }

  Future<void> topUpTopay(
    String userId,
    String itemId,
    String paymentCategoryId,
    String transactionTarget,
  ) async {
    try {
      final Map<String, dynamic> data = {
        "user_id": userId,
        "admin_id": "411de7ad-044a-4dac-8b38-85616a7ee517",
        "item_id": itemId,
        "payment_category_id": paymentCategoryId,
        "transaction_target": transactionTarget,
        "status": "sedang diproses",
      };
      final response = await http.post(
        Uri.parse("$baseUrl/topUpTopay"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);
      } else {
        debugPrint(response.body);
        throw Exception(response.body);
      }
    } catch (e) {
      debugPrint("error top up topay:$e");
      rethrow;
    }
  }

  Future<List<TransactionModel>> getTransaction(String userId) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/transaction/$userId"));
      if (response.statusCode == 200) {
        debugPrint("transaksi user:${response.body}");
        final List result = jsonDecode(response.body)["data"];
        return result
            .map(
              (json) => TransactionModel.fromJson(json),
            )
            .toList();
      } else {
        debugPrint(response.body);
        return [];
      }
    } catch (e) {
      debugPrint("Error get transaction:$e");
      return [];
    }
  }
}
