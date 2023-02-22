import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileRepository {
  User get userDetail;
  Future<void> logout();
}
