import 'package:horario_corte_luz/domain/datasources/UserPreferenceDatasource.dart';
import 'package:horario_corte_luz/domain/entities/UserPreference.dart';

class DbUserPreferenceDatasourceImpl extends UserPreferenceDatasource {
  @override
  Future<UserPreference> getUserPreference() {
    // TODO: implement getUserPreference
    return Future.value(UserPreference(
        isDarkModeOn: false, isLogged: false, userName: '', idUser: 1));
  }
}
