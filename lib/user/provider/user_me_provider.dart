import 'package:codefactory_flutter/common/const/data.dart';
import 'package:codefactory_flutter/user/model/user_model.dart';
import 'package:codefactory_flutter/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserMeStateNotifier  extends StateNotifier<UserModelBase?> {
  UserMeStateNotifier({
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    getMe();
  }

  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }

    final resp = await repository.getMe();
    state = resp;
  }
}