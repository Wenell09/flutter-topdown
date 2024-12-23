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
}
