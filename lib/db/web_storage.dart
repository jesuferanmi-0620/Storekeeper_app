import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class WebStorage {
  static const String _key = 'products';

  static Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_key);
    if (data == null) return [];
    
    final List<dynamic> jsonList = json.decode(data);
    return jsonList.map((json) => Product.fromMap(json)).toList();
  }

  static Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final String data = json.encode(products.map((p) => p.toMap()).toList());
    await prefs.setString(_key, data);
  }
}