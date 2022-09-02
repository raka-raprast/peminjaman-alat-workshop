// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_hydrated_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileChangeState _$ProfileChangeStateFromJson(Map<String, dynamic> json) =>
    ProfileChangeState(
      profile: (json['profile'] as List<dynamic>)
          .map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileChangeStateToJson(ProfileChangeState instance) =>
    <String, dynamic>{
      'profile': instance.profile,
    };

ProfileLoadingState _$ProfileLoadingStateFromJson(Map<String, dynamic> json) =>
    ProfileLoadingState();

Map<String, dynamic> _$ProfileLoadingStateToJson(
        ProfileLoadingState instance) =>
    <String, dynamic>{};
