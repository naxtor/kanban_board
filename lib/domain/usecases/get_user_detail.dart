import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanban_board/domain/repositories/profile_repository.dart';

class GetUserDetail {
  ProfileRepository profileRepository;

  GetUserDetail(this.profileRepository);

  User execute() {
    try {
      return profileRepository.userDetail;
    } catch (e) {
      rethrow;
    }
  }
}
