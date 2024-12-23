import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:topdown_store/data/constant/base_url.dart';
import 'package:topdown_store/data/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepo {
  Future<List<UserModel>> getAccount(String userId) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/account/$userId"));
      if (response.statusCode == 200) {
        debugPrint("berhasil get akun dengan id:$userId");
        final List result = jsonDecode(response.body)["data"];
        return result.map((json) => UserModel.fromJson(json)).toList();
      } else {
        debugPrint(response.body);
        return [];
      }
    } catch (e) {
      debugPrint("Error get account:$e");
      return [];
    }
  }

  Future<void> editAccount(
    String userId,
    String username,
    String email,
    String password,
  ) async {
    try {
      final Map<String, dynamic> data = {
        "username": username,
        "email": email,
        "password": password,
      };
      final response = await http.patch(
        Uri.parse("$baseUrl/editAccount/$userId"),
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
      debugPrint("gagal edit account:$e");
      rethrow;
    }
  }

  Future<void> deleteAccount(String userId) async {
    try {
      final response =
          await http.delete(Uri.parse("$baseUrl/deleteAccount/$userId"));
      if (response.statusCode == 200) {
        debugPrint(response.body);
      } else {
        debugPrint(response.body);
        throw Exception(response.body);
      }
    } catch (e) {
      debugPrint("error delete Account");
      rethrow;
    }
  }
}
