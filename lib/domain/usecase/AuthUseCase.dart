import 'package:horario_corte_luz/architecture/datasource/AuthDatasourceImpl.dart';
import 'package:horario_corte_luz/architecture/repository/AuthRepositoryImpl.dart';
import 'package:horario_corte_luz/core/LSConsts.dart';
import 'package:horario_corte_luz/domain/entities/UserPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUseCase {
  AuthUseCase();

  Future<bool> login({required String email, required String password}) async {
    final prefs = await SharedPreferences.getInstance();
    UserPreference response =
        await AuthRepositoryImpl(authDatasource: AuthDatasourceImpl())
            .loginUser(email: email, password: password);

    await prefs.setString(LSConsts.userDataKey, response.toJson());

    return true;
  }

  Future<bool> registerUser(
      {required String email,
      required String password,
      required String userName}) async {
    final prefs = await SharedPreferences.getInstance();
    UserPreference response =
        await AuthRepositoryImpl(authDatasource: AuthDatasourceImpl())
            .registerUser(email: email, password: password, userName: email);

    await prefs.setString(LSConsts.userDataKey, response.toJson());

    return true;
  }
}
