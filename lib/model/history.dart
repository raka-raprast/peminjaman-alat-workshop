// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history.g.dart';

@JsonSerializable()
class History extends Equatable {
  final String borrowTime;
  final String returnTime;
  final String status;
  final int borrowedItemQty;
  final String id;

  History(
      {required this.borrowTime,
      this.returnTime = '',
      required this.status,
      required this.borrowedItemQty,
      required this.id});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$HistoryToJson(this);

  @override
  List<Object?> get props => [
        borrowTime,
        returnTime,
        status,
        borrowedItemQty,
        id,
      ];
}
