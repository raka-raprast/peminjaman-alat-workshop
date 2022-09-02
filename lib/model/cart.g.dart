// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      name: json['name'] as String,
      image: json['image'] as String,
      qty: json['qty'] as int,
      remark: json['remark'] as String,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'qty': instance.qty,
      'remark': instance.remark,
    };
