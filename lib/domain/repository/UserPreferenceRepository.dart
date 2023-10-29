import 'package:horario_corte_luz/domain/entities/UserPreference.dart';

abstract class UserPreferenceRepository {
  Future<UserPreference> getUserPreference();
}
