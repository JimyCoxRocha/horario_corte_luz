import 'package:horario_corte_luz/domain/datasources/UserPreferenceDatasource.dart';
import 'package:horario_corte_luz/domain/entities/UserPreference.dart';
import 'package:horario_corte_luz/domain/repository/UserPreferenceRepository.dart';

class UserPreferenceRepositoryImpl implements UserPreferenceRepository {
  final UserPreferenceDatasource userPreferenceDatasource;

  UserPreferenceRepositoryImpl({required this.userPreferenceDatasource});

  @override
  Future<UserPreference> getUserPreference() {
    // TODO: implement getUserPreference
    return this.userPreferenceDatasource.getUserPreference();
  }
}
