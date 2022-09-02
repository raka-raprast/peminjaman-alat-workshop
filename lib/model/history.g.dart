// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) => History(
      borrowTime: json['borrowTime'] as String,
      returnTime: json['returnTime'] as String,
      status: json['status'] as String,
      borrowedItemQty: json['borrowItemQty'] as int,
      id: json['uid'] as String,
    );

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'borrowTime': instance.borrowTime,
      'returnTime': instance.returnTime,
      'status': instance.status,
      'borrowItemQty': instance.borrowedItemQty,
      'uid': instance.id,
    };
