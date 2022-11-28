import 'package:codefactory_flutter/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider = StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);
  return notifier;
});

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  RestaurantStateNotifier({
    required this.repository
  }): super(CursorPaginationLoading()) {
    paginate();
  }

  final RestaurantRepository repository;

  paginate() async {
    final resp = await repository.paginate();
    state = resp;
  }
}