import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final int id;
  final String name;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  const CategoryModel({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  String? get image => imageUrl;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
