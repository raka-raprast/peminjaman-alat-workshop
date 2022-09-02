// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'processed_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessedCart _$ProcessedCartFromJson(Map<String, dynamic> json) =>
    ProcessedCart(
      name: json['name'] as String,
      image: json['image'] as String,
      qty: json['qty'] as int,
      remark: json['remark'] as String,
      id: json['uid'] as String,
    );

Map<String, dynamic> _$ProcessedCartToJson(ProcessedCart instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'qty': instance.qty,
      'remark': instance.remark,
      'uid': instance.id,
    };
