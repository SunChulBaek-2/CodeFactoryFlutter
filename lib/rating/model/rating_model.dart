import 'package:codefactory_flutter/common/utils/data_utils.dart';
import 'package:codefactory_flutter/user/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel {
  RatingModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.content,
    @JsonKey(fromJson: DataUtils.listPathsToUrls) required this.imageUrls,
  });

  final String id;
  final UserModel user;
  final int rating;
  final String content;
  final List<String> imageUrls;

  factory RatingModel.fromJson(Map<String, dynamic> json) => _$RatingModelFromJson(json);
}