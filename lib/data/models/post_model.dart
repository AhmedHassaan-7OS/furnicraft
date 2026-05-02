import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  final int id;
  final String title;
  final String? excerpt;
  final String? image;

  const PostModel({
    required this.id,
    required this.title,
    this.excerpt,
    this.image,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
