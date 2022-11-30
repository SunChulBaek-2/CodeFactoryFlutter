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

    // 바로 반환하는 상황
    // 1) hasMore = false
    // 2) 로딩중 - fetchMore : true
    //    fetchMore 아닐 때는 새로 고침의 의도가 있다.
    if (state is CursorPagination && !forceRefetch) {
      final pState = state as CursorPagination;
      if (!pState.meta.hasMore) {
        return;
      }
    }
    final isLoading = state is CursorPaginationLoading;
    final isRefetching = state is CursorPaginationRefetching;
    final isFetchingMore = state is CursorPaginationFetchingMore;
    if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
      return;
    }
  }
}