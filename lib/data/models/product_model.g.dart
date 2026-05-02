// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  price: (json['price'] as num).toDouble(),
  categoryId: json['categoryId'] as String?,
  sku: json['sku'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  imageUrl: json['imageUrl'] as String?,
  images: (json['images'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  specs: json['specs'] as Map<String, dynamic>?,
  isFeatured: json['isFeatured'] as bool? ?? false,
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'categoryId': instance.categoryId,
      'sku': instance.sku,
      'tags': instance.tags,
      'imageUrl': instance.imageUrl,
      'images': instance.images,
      'specs': instance.specs,
      'isFeatured': instance.isFeatured,
    };
