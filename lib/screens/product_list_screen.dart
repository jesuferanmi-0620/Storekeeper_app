import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'add_edit_product_screen.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _products = ProductService.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: _products[index],
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: _products[index]))),
            onEdit: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditProductScreen(product: _products[index]))).then((_) => _loadProducts()),
            onDelete: () {
              ProductService.delete(_products[index].id!);
              _loadProducts();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditProductScreen())).then((_) => _loadProducts()),
        child: Icon(Icons.add),
      ),
    );
  }
}