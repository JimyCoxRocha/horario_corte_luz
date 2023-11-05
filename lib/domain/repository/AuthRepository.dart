import 'package:horario_corte_luz/domain/entities/UserPreference.dart';

abstract class AuthRepository {
  Future<UserPreference> loginUser(
      {required String email, required String password});
  Future<UserPreference> registerUser(
      {required String email,
      required String password,
      required String userName});
}
