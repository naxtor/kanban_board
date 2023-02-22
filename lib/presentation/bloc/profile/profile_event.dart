import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List get props => [];
}

class GetProfileEvent extends ProfileEvent {
  final User user;

  GetProfileEvent(this.user);

  @override
  List get props => [
        user,
      ];
}

class LogoutEvent extends ProfileEvent {
  final BuildContext context;

  LogoutEvent(this.context);

  @override
  List get props => [
        context,
      ];
}
