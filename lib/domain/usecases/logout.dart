import 'package:kanban_board/domain/repositories/profile_repository.dart';

class Logout {
  ProfileRepository profileRepository;

  Logout(this.profileRepository);

  Future<void> execute() {
    try {
      return profileRepository.logout();
    } catch (e) {
      rethrow;
    }
  }
}
