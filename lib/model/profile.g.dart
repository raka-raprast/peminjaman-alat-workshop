// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      name: json['user'] as String,
      id: json['userid'] as String,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.name,
      'userid': instance.id,
    };
