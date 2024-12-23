import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:topdown_store/data/constant/base_url.dart';

class AuthRepo {
  Future<String> addAccount(
      String username, String email, String password) async {
    try {
      Map<String, dynamic> data = {
        "username": username,
        "email": email,
        "role": "user",
        "password": password,
        "saldo": 0,
        "image":
            "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"
      };
      final response = await http.post(
        Uri.parse("$baseUrl/addAccount"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);
        final String result = jsonDecode(response.body)["user_id"];
        return result;
      } else {
        debugPrint(response.body);
        final String errorMessage = jsonDecode(response.body)["message"];
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint("Error add account:$e");
      rethrow;
    }
  }

  Future<String> loginAccount(String email, String password) async {
    try {
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
      };
      final response = await http.post(
        Uri.parse("$baseUrl/loginAccount"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        debugPrint(response.body);
        final String userId = jsonDecode(response.body)["user_id"];
        return userId;
      } else {
        debugPrint(response.body);
        final String errorMessage = jsonDecode(response.body)["message"];
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint("Error login account:$e");
      rethrow;
    }
  }
}
