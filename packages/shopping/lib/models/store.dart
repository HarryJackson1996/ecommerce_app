import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  Categories({
    required this.categories,
  });

  final List<Category> categories;

  @override
  List<Object?> get props => [categories];
}

class Category extends Equatable {
  const Category({
    required this.name,
    required this.products,
  });

  final String name;
  final List<Product>? products;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json['name'],
        products: const [],
      );

  Category copyWith({
    String? name,
    List<Product>? products,
  }) =>
      Category(
        name: name ?? this.name,
        products: products ?? this.products,
      );

  @override
  List<Object?> get props => [name, products];
}

class Product {
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
    required this.rating,
  });

  final int id;
  final String title;
  final double price;
  final String category;
  final String description;
  final String image;
  final Rating rating;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        price: json['price'].toDouble(),
        category: json['category'],
        description: json['description'],
        image: json['image'],
        rating: Rating.fromJson(json['rating']),
      );
}

class Rating {
  Rating({
    required this.rate,
    required this.count,
  });

  final double rate;
  final int count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json['rate'].toDouble(),
        count: json['count'],
      );
}
