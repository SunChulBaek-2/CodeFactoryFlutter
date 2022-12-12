import 'dart:async';

import 'package:codefactory_flutter/common/view/root_tab.dart';
import 'package:codefactory_flutter/common/view/splash_screen.dart';
import 'package:codefactory_flutter/restaurant/view/restaurant_detail_screen.dart';
import 'package:codefactory_flutter/user/model/user_model.dart';
import 'package:codefactory_flutter/user/provider/user_me_provider.dart';
import 'package:codefactory_flutter/user/view/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvier = ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider(ref: ref));

class AuthProvider extends ChangeNotifier {
  AuthProvider({required this.ref}) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  final Ref ref;

  List<GoRoute> get routes => [
    GoRoute(
      path: '/',
      name: RootTab.routeName,
      builder: (context, state) => const RootTab(),
      routes: [
        GoRoute(
          path: 'restaurant/:rid',
          name: RestaurantDetailScreen.routeName,
          builder: (context, state) => RestaurantDetailScreen(
              param: RestaurantDetailParam(id: state.params['rid']!, item: null)),
        )
      ]
    ),
    GoRoute(
      path: '/splash',
      name: SplashScreen.routeName,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
  ];

  FutureOr<String?> redirectLogic(GoRouterState state) async {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.location == '/login';

    if (user == null) {
      return logginIn ? null : '/login';
    }

    if (user is UserModel) {
      return logginIn || state.location == '/splash' ? '/' : null;
    }

    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }

    return null;
  }
}