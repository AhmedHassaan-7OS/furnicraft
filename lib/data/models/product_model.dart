import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int id;
  final String name;
  final String? description;
  final double price;
  @JsonKey(name: 'categoryId')
  final String? categoryId;
  final String? sku;
  final List<String>? tags;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @JsonKey(name: 'images')
  final List<String>? images;
  final Map<String, dynamic>? specs;
  @JsonKey(name: 'isFeatured')
  final bool isFeatured;

  const ProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.categoryId,
    this.sku,
    this.tags,
    this.imageUrl,
    this.images,
    this.specs,
    this.isFeatured = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  // Helper getters for backward compatibility if needed, 
  // but better to use the new names.
  String? get image => imageUrl;
  List<String>? get gallery => images;
}
