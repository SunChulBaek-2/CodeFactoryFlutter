import 'package:codefactory_flutter/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.id,
    required this.username,
    @JsonKey(fromJson: DataUtils.pathToUrl) required this.imageUrl,
  });

  final String id;
  final String username;
  final String imageUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}