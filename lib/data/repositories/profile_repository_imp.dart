import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanban_board/data/datasources/auth_service.dart';
import 'package:kanban_board/domain/repositories/profile_repository.dart';

class ProfileRepositoryImplement extends ProfileRepository {
  AuthService authService;

  ProfileRepositoryImplement(this.authService);

  @override
  User get userDetail => authService.userDetail;

  @override
  Future<void> logout() async {
    authService.logout();
  }
}
