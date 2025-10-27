import 'package:flutter/material.dart';
import '../models/product.dart';

class AddEditProductScreen extends StatefulWidget {
  final Product? product;
  AddEditProductScreen({this.product});

  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late double _price;

  @override
  void initState() {
    super.initState();
    _name = widget.product?.name ?? '';
    _description = widget.product?.description ?? '';
    _price = widget.product?.price ?? 0.0;
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final product = Product(
        id: widget.product?.id,
        name: _name,
        description: _description,
        price: _price,
      );
      if (widget.product == null) {
        ProductService.add(product);
      } else {
        ProductService.update(product);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product == null ? 'Add Product' : 'Edit Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Enter description' : null,
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter price' : null,
                onSaved: (value) => _price = double.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}