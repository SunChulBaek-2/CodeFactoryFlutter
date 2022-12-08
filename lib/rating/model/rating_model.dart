import 'package:codefactory_flutter/common/model/model_with_id.dart';
import 'package:codefactory_flutter/common/utils/data_utils.dart';
import 'package:codefactory_flutter/user/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements IModelWithId {
  RatingModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.content,
    @JsonKey(fromJson: DataUtils.listPathsToUrls) required this.imgUrls,
  });

  @override
  final String id;
  final UserModel user;
  final int rating;
  final String content;
  final List<String> imgUrls;

  factory RatingModel.fromJson(Map<String, dynamic> json) => _$RatingModelFromJson(json);
}