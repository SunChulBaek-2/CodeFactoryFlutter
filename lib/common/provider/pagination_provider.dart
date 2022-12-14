import 'package:codefactory_flutter/common/model/cursor_pagination_model.dart';
import 'package:codefactory_flutter/common/model/model_with_id.dart';
import 'package:codefactory_flutter/common/model/pagination_params.dart';
import 'package:codefactory_flutter/common/repository/base_pagination_repository.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _PaginationInfo {
  _PaginationInfo({
    this.fetchCount = 20,
    this.fetchMore = false,
    this.forceRefetch = false
  });

  final int fetchCount;
  final bool fetchMore;
  final bool forceRefetch;
}

class PaginationProvider<
  T extends IModelWithId,
  U extends IBasePaginationRepository<T>
> extends StateNotifier<CursorPaginationBase> {
  PaginationProvider({
    required this.repository
  }) : super(CursorPaginationLoading()) {
    paginate();
    paginationThrottle.values.listen((event) {
       _throttlePagination(event);
    });
  }

  final U repository;
  final paginationThrottle = Throttle(
    const Duration(seconds: 3),
    initialValue: _PaginationInfo(),
    checkEquality: false,
  );

  Future<void> paginate({
    int fetchCount = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    paginationThrottle.setValue(_PaginationInfo(
      fetchCount: fetchCount,
      fetchMore: fetchMore,
      forceRefetch: forceRefetch
    ));
  }

  _throttlePagination(_PaginationInfo info) async {
    final fetchCount = info.fetchCount;
    final fetchMore = info.fetchMore;
    final forceRefetch = info.forceRefetch;
    try {
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

      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore : 데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination;
        state =
            CursorPaginationFetchingMore(meta: pState.meta, data: pState.data);
        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      } else { // 데이터를 처음부터 가져오는 상황
        // 데이터가 있는 상황이라면, 기존 데이터 보존한 채로 fetch
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;
          state =
              CursorPaginationRefetching<T>(meta: pState.meta, data: pState.data);
        } else {
          state = CursorPaginationLoading();
        }
      }
      final resp = await repository.paginate(
          paginationParams: paginationParams
      );
      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;
        // 기존 데이터에 새로운 데이터 추가
        state = CursorPagination<T>(
            meta: resp.meta,
            data: [
              ...pState.data,
              ...resp.data,
            ]
        );
      } else {
        state = resp;
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}