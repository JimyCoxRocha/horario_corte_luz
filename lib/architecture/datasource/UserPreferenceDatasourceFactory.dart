import 'package:horario_corte_luz/architecture/datasource/DbUserPreferenceDatasourceImpl.dart';
import 'package:horario_corte_luz/architecture/datasource/LSUserPreferenceDatasourceImpl.dart';
import 'package:horario_corte_luz/domain/datasources/UserPreferenceDatasource.dart';

class UserPreferenceDatasourceFactory {
  UserPreferenceDatasourceFactory();

  static UserPreferenceDatasource userPreferenceDatasource(
      {bool lSData = false}) {
    if (lSData) {
      return LSUserPreferenceDatasourceImpl();
    } else {
      return DbUserPreferenceDatasourceImpl();
    }
  }
}
