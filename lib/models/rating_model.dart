import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class RatingModel {
  @HiveField(0)
  final double rate;
  @HiveField(1)
  final int count;

  RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => _$RatingModelFromJson(json);
}
