// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  price: (json['price'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String,
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  categoryId: json['categoryId'] as String,
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
  isFeatured: json['isFeatured'] as bool? ?? false,
  isRecommended: json['isRecommended'] as bool? ?? false,
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'images': instance.images,
      'categoryId': instance.categoryId,
      'rating': instance.rating,
      'reviewsCount': instance.reviewsCount,
      'isFeatured': instance.isFeatured,
      'isRecommended': instance.isRecommended,
    };
