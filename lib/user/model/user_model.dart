import 'package:codefactory_flutter/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

abstract class UserModelBase { }

class UserModelError extends UserModelBase {
  UserModelError({
    required this.message
  });

  final String message;
}

class UserModelLoading extends UserModelBase { }

@JsonSerializable()
class UserModel extends UserModelBase {
  UserModel({
    required this.id,
    required this.username,
    required this.imageUrl,
  });

  final String id;
  final String username;
  @JsonKey(fromJson: DataUtils.pathToUrl) final String imageUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}