import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/domain/usecases/get_user_detail.dart';
import 'package:kanban_board/domain/usecases/logout.dart';
import 'package:kanban_board/presentation/bloc/profile/profile_event.dart';
import 'package:kanban_board/presentation/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetUserDetail getUserDetail;
  Logout logout;

  ProfileBloc({
    required this.getUserDetail,
    required this.logout,
  }) : super(ProfileEmpty()) {
    on<GetProfileEvent>((event, emit) async {
      emit(ProfileHasData(event.user));
    });
    on<LogoutEvent>((event, emit) async {
      await logout.execute();

      Future.delayed(
        const Duration(
          seconds: 1,
        ),
        () => Navigator.of(event.context)
            .pushNamedAndRemoveUntil("/login", (route) => false),
      );
    });
  }
}
