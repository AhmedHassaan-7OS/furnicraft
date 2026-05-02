// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  excerpt: json['excerpt'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'excerpt': instance.excerpt,
  'image': instance.image,
};
