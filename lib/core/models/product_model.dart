import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> images;
  final String categoryId;
  final double rating;
  final int reviewsCount;
  final bool isFeatured;
  final bool isRecommended;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.images = const [],
    required this.categoryId,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.isFeatured = false,
    this.isRecommended = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
