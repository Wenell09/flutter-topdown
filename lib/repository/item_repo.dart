import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topdown_store/data/constant/base_url.dart';
import 'package:topdown_store/data/model/item_model.dart';

class ItemRepo {
  Future<List<ItemModel>> getItem(String productId) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/item/$productId"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        debugPrint(
            "berhasil get item dengan id$productId,jumlah item:${result.length}");
        return result.map((json) => ItemModel.fromJson(json)).toList();
      } else {
        debugPrint(response.body);
        return [];
      }
    } catch (e) {
      debugPrint("error item:$e");
      return [];
    }
  }

  Future<void> addItem(
    String name,
    String productId,
    int price,
    String image,
  ) async {
    try {
      final Map<String, dynamic> data = {
        "name": name,
        "product_id": productId,
        "price": price,
        "image": image,
      };
      final response = await http.post(
        Uri.parse("$baseUrl/addItem"),
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
      debugPrint("error add item:$e");
      rethrow;
    }
  }

  Future<void> editItem(
    String itemId,
    String name,
    String productId,
    int price,
    String image,
  ) async {
    try {
      final Map<String, dynamic> data = {
        "name": name,
        "product_id": productId,
        "price": price,
        "image": image,
      };
      final response = await http.patch(
        Uri.parse("$baseUrl/editItem/$itemId"),
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
      debugPrint("error edit item:$e");
      rethrow;
    }
  }

  Future<void> deleteItem(String itemId) async {
    try {
      final response =
          await http.delete(Uri.parse("$baseUrl/deleteItem/$itemId"));
      if (response.statusCode == 200) {
        debugPrint(response.body);
      } else {
        debugPrint(response.body);
        throw Exception(response.body);
      }
    } catch (e) {
      debugPrint("error delete item:$e");
      rethrow;
    }
  }
}
