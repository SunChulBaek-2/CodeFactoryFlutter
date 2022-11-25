import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CursorPagination<T> {
  CursorPagination({required this.meta, required this.data});

  final CursorPaginationMeta meta;
  final List<T> data;

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

  @override
  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}