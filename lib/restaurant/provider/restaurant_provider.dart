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

  paginate({
    int fetchCount = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    // 5가지 가능성
    // State의 상태
    // [상태가]
    // 1) CursorPagination
    // 2) CursorPaginationLoading
    // 3) CursorPaginationError
    // 4) CursorPaginationRefetching
    // 5) CursorPaginationFetchMore
  }
}