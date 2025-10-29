import 'package:flutter/foundation.dart';
import '../db/database_helper.dart';
import '../db/web_storage.dart';

class Product {
  int? id;
  String name;
  int quantity;
  double price;
  List<String> imagePaths;

  Product({
    this.id,
    required this.name,
    required this.quantity,
    required this.price,
    List<String>? imagePaths,
  }) : imagePaths = imagePaths ?? [];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'imagePaths': imagePaths.join(','),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    String imagePathsStr = map['imagePaths'] ?? '';
    List<String> paths = imagePathsStr.isEmpty ? [] : imagePathsStr.split(',');
    return Product(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'] ?? 0,
      price: map['price'],
      imagePaths: paths,
    );
  }
}

class ProductService {
  static final DatabaseHelper _dbHelper = DatabaseHelper();

  static Future<List<Product>> getAll() async {
    try {
      if (kIsWeb) {
        return await WebStorage.getProducts();
      } else {
        return await _dbHelper.getAllProducts();
      }
    } catch (e) {
      return [];
    }
  }

  static Future<void> add(Product product) async {
    try {
      if (kIsWeb) {
        final products = await getAll();
        product.id = products.length + 1;
        products.add(product);
        await WebStorage.saveProducts(products);
      } else {
        int id = await _dbHelper.insertProduct(product);
        product.id = id;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> update(Product updatedProduct) async {
    try {
      if (kIsWeb) {
        final products = await getAll();
        final index = products.indexWhere((p) => p.id == updatedProduct.id);
        if (index != -1) {
          products[index] = updatedProduct;
          await WebStorage.saveProducts(products);
        }
      } else {
        await _dbHelper.updateProduct(updatedProduct);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> delete(int id) async {
    try {
      if (kIsWeb) {
        final products = await getAll();
        products.removeWhere((p) => p.id == id);
        await WebStorage.saveProducts(products);
      } else {
        await _dbHelper.deleteProduct(id);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Product?> getById(int id) async {
    try {
      final products = await getAll();
      return products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  static bool _initialized = false;
  
  static Future<void> initializeWithSampleData() async {
    if (_initialized) return;
    _initialized = true;
    
    try {
      final products = await getAll();
      if (products.isEmpty) {
        await add(Product(name: 'Sample Product', quantity: 10, price: 15.99));
      }
    } catch (e) {
      // Continue without sample data
    }
  }
}