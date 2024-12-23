import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topdown_store/data/constant/base_url.dart';
import 'package:topdown_store/data/model/product_model.dart';

class ProductRepo {
  Future<List<ProductModel>> getProduct(String categoryId) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/product/$categoryId"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        debugPrint(
            "berhasil get product untuk id:$categoryId,jumlah product:${result.length}");
        return result.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        debugPrint(response.body);
        return [];
      }
    } catch (e) {
      debugPrint("error product:$e");
      return [];
    }
  }

  Future<List<ProductModel>> searchProduct(String name) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/searchProduct?name=$name"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        debugPrint("berhasil search product $name");
        return result.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        debugPrint(response.body);
        return [];
      }
    } catch (e) {
      debugPrint("error product:$e");
      return [];
    }
  }

  Future<void> addProduct(
      String productId, String name, String categoryId, String image) async {
    try {
      final Map<String, dynamic> data = {
        "product_id": productId,
        "name": name,
        "category_id": categoryId,
        "image": image
      };
      final response = await http.post(
        Uri.parse("$baseUrl/addProduct"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);
      } else {
        debugPrint(response.body);
      }
    } catch (e) {
      debugPrint("error add product:$e");
    }
  }

  Future<void> editProduct(
      String productId, String name, String categoryId, String image) async {
    try {
      final Map<String, dynamic> data = {
        "name": name,
        "category_id": categoryId,
        "image": image
      };
      final response = await http.patch(
        Uri.parse("$baseUrl/editProduct/$productId"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);
      } else {
        debugPrint(response.body);
      }
    } catch (e) {
      debugPrint("error edit product:$e");
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      final response =
          await http.delete(Uri.parse("$baseUrl/deleteProduct/$productId"));
      if (response.statusCode == 200) {
        debugPrint(response.body);
      } else {
        debugPrint(response.body);
      }
    } catch (e) {
      debugPrint("error delete product:$e");
    }
  }
}
