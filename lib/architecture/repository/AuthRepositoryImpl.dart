import 'package:horario_corte_luz/domain/datasources/AuthDatasource.dart';
import 'package:horario_corte_luz/domain/entities/UserPreference.dart';
import 'package:horario_corte_luz/domain/repository/AuthRepository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl({required this.authDatasource});

  @override
  Future<UserPreference> loginUser(
      {required String email, required String password}) async {
    final response =
        await authDatasource.loginUser(email: email, password: password);
    return UserPreference(
        userName: response.userName,
        isLogged: true,
        isDarkModeOn: null,
        idUser: response.idUser);
  }

  @override
  Future<UserPreference> registerUser(
      {required String email,
      required String password,
      required String userName}) async {
    final response = await authDatasource.registerUser(
        email: email, password: password, userName: userName);
    return UserPreference(
        userName: response.userName,
        isLogged: true,
        isDarkModeOn: null,
        idUser: response.idUser);
  }
}
