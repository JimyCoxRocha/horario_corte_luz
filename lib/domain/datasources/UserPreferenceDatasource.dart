import 'package:horario_corte_luz/domain/entities/UserPreference.dart';

abstract class UserPreferenceDatasource {
  Future<UserPreference> getUserPreference();
}
