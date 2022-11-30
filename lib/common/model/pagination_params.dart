import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams {
  const PaginationParams({
    this.after,
    this.count
  });

  final String? after;
  final int? count;

  PaginationParams copyWith({
    String? after,
    int? count,
  }) => PaginationParams(
    after: after ?? this.after,
    count: count ?? this.count
  );

  factory PaginationParams.fromJson(Map<String, dynamic> json) => _$PaginationParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);
}