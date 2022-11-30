import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {}

class CursorPaginationLoading extends CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  CursorPaginationError({required this.message});

  final String message;
}

@JsonSerializable(genericArgumentFactories: true)
class CursorPagination<T> extends CursorPaginationBase {
  CursorPagination({required this.meta, required this.data});

  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination copyWith({
    CursorPaginationMeta? meta,
    List<T>? data
  }) => CursorPagination(
    meta: meta ?? this.meta,
    data: data ?? this.data,
  );

  @override
  factory CursorPagination.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT
  ) => _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  CursorPaginationMeta({required this.count, required this.hasMore});

  final int count;
  final bool hasMore;

  CursorPaginationMeta copyWith({
    int? count,
    bool? hasMore
  }) => CursorPaginationMeta(
    count: count ?? this.count,
    hasMore: hasMore ?? this.hasMore
  );

  @override
  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}

class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.meta,
    required super.data,
  });
}

class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });
}