class Product {
  int? id;
  String name;
  String description;
  double price;
  String? imagePath;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imagePath': imagePath,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      imagePath: map['imagePath'],
    );
  }
}

class ProductService {
  static List<Product> products = [
    Product(id: 1, name: 'Product 1', description: 'Description 1', price: 10.0),
    Product(id: 2, name: 'Product 2', description: 'Description 2', price: 20.0),
  ];

  static List<Product> getAll() {
    return products;
  }

  static void add(Product product) {
    product.id = products.length + 1;
    products.add(product);
  }

  static void update(Product updatedProduct) {
    int index = products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      products[index] = updatedProduct;
    }
  }

  static void delete(int id) {
    products.removeWhere((p) => p.id == id);
  }
}