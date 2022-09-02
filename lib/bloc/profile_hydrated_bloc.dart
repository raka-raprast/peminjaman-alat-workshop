// ignore_for_file: unnecessary_this, prefer_const_constructors, prefer_const_literals_to_create_immutables, overridden_fields, annotate_overrides

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:peminjaman_alat_workshop/model/profile.dart';

part 'profile_hydrated_bloc.g.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileAddEvent extends ProfileEvent {
  final Profile profile;

  const ProfileAddEvent(this.profile);

  @override
  List<Object> get props => [profile];
}

class ProfileCheckEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class ProfileRemoveEvent extends ProfileEvent {
  final Profile profile;

  const ProfileRemoveEvent(this.profile);

  @override
  List<Object> get props => [profile];
}

abstract class ProfileState extends Equatable {
  final List<Profile> profile;

  const ProfileState({required this.profile});

  @override
  List<Object> get props => [profile];
}

@JsonSerializable()
class ProfileChangeState extends ProfileState {
  final List<Profile> profile;

  const ProfileChangeState({required this.profile}) : super(profile: profile);

  @override
  List<Object> get props => [profile];

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ProfileChangeState.fromJson(Map<String, dynamic> json) =>
      _$ProfileChangeStateFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson(ProfileChangeState state) =>
      _$ProfileChangeStateToJson(state);
}

@JsonSerializable()
class ProfileLoadingState extends ProfileState {
  ProfileLoadingState() : super(profile: []);

  @override
  List<Object> get props => [];

  @override

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ProfileLoadingState.fromJson(Map<String, dynamic> json) =>
      _$ProfileLoadingStateFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson(ProfileLoadingState state) =>
      _$ProfileLoadingStateToJson(state);
}

class ProfileHydratedBloc extends HydratedBloc<ProfileEvent, ProfileState> {
  ProfileHydratedBloc() : super(ProfileChangeState(profile: [])) {
    on<ProfileAddEvent>(_add);
    on<ProfileRemoveEvent>(_remove);
    on<ProfileCheckEvent>(_check);
  }

  void _add(ProfileAddEvent event, Emitter<ProfileState> emit) {
    var term = event.profile;

    emit(ProfileLoadingState());
    emit(ProfileChangeState(profile: [term]));
  }

  void _remove(ProfileRemoveEvent event, Emitter<ProfileState> emit) {
    emit(ProfileLoadingState());
    emit(ProfileChangeState(profile: []));
  }

  void _check(ProfileCheckEvent event, Emitter<ProfileState> emit) {
    var current = this.state.profile;
    emit(ProfileLoadingState());
    emit(ProfileChangeState(profile: current));
  }

  @override
  ProfileState fromJson(Map<String, dynamic> json) =>
      _$ProfileChangeStateFromJson(json);

  @override
  Map<String, dynamic> toJson(ProfileState state) {
    if (state is ProfileLoadingState) {
      return _$ProfileLoadingStateToJson(state);
    } else {
      return _$ProfileChangeStateToJson(state as ProfileChangeState);
    }
  }
}
