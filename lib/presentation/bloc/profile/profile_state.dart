import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileState extends Equatable {
  @override
  List get props => [];
}

class ProfileEmpty extends ProfileState {}

class ProfileHasData extends ProfileState {
  final User user;

  ProfileHasData(this.user);

  @override
  List get props => [
        user,
      ];
}
