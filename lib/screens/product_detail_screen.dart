import 'package:flutter/material.dart';
import 'dart:io';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imagePath != null) Image.file(File(product.imagePath!)),
            Text('Name: ${product.name}', style: TextStyle(fontSize: 20)),
            Text('Description: ${product.description}'),
            Text('Price: \$${product.price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}