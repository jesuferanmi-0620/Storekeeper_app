import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/product.dart';
import '../providers/theme_provider.dart';
import '../widgets/universal_image.dart';
import 'settings_screen.dart';

class AddEditProductScreen extends StatefulWidget {
  final Product? existingProduct;

  const AddEditProductScreen({super.key, this.existingProduct});

  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late String productName;
  late int quantity;
  late double price;
  List<String> _imagePaths = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    productName = widget.existingProduct?.name ?? '';
    quantity = widget.existingProduct?.quantity ?? 0;
    price = widget.existingProduct?.price ?? 0.0;
    _imagePaths = List.from(widget.existingProduct?.imagePaths ?? []);
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newProduct = Product(
        name: productName,
        quantity: quantity,
        price: price,
        imagePaths: _imagePaths,
      );

      try {
        if (widget.existingProduct != null) {
          // Update existing product
          newProduct.id = widget.existingProduct!.id;
          await ProductService.update(newProduct);
        } else {
          // Add new product
          await ProductService.add(newProduct);
        }
        Navigator.pop(context, newProduct);
      } catch (e) {
        print('Save error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving product: $e')),
        );
      }
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );
      if (image != null) {
        setState(() {
          _imagePaths.add(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error accessing camera')),
      );
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _imagePaths.add(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error accessing gallery')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingProduct != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Product' : 'Add New Product'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
                tooltip: themeProvider.isDarkMode
                    ? 'Switch to Light Mode'
                    : 'Switch to Dark Mode',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Product Name
              TextFormField(
                initialValue: productName,
                decoration: InputDecoration(
                  labelText: 'Product Name *',
                  hintText: 'Enter product name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => productName = value!,
              ),
              SizedBox(height: 16),

              // Quantity
              TextFormField(
                initialValue: widget.existingProduct != null ? quantity.toString() : '',
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => quantity = int.tryParse(value!) ?? 0,
              ),
              SizedBox(height: 16),

              // Price
              TextFormField(
                initialValue: widget.existingProduct != null ? price.toStringAsFixed(2) : '',
                decoration: InputDecoration(
                  labelText: 'Price (\$)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSaved: (value) => price = double.tryParse(value!) ?? 0.0,
              ),
              SizedBox(height: 24),

              // Image Upload Options
              Text('Product Image', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),

              // Display selected images if available
              if (_imagePaths.isNotEmpty) ...[
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _imagePaths.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100,
                        margin: EdgeInsets.only(right: 8),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: UniversalImage(
                                imagePath: _imagePaths[index],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _imagePaths.removeAt(index);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.close, color: Colors.white, size: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
              ],

              // Image selection buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.photo_library),
                      label: Text('Add from Gallery'),
                      onPressed: _pickImageFromGallery,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.camera_alt),
                      label: Text('Take Photo'),
                      onPressed: _pickImageFromCamera,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _saveProduct,
                    child: Text(isEditing ? 'Update Product' : 'Add Product'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}