import 'package:horario_corte_luz/core/LSConsts.dart';
import 'package:horario_corte_luz/domain/datasources/UserPreferenceDatasource.dart';
import 'package:horario_corte_luz/domain/entities/UserPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LSUserPreferenceDatasourceImpl extends UserPreferenceDatasource {
  @override
  Future<UserPreference> getUserPreference() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.get(LSConsts.userDataKey));

    final valueData = prefs.getString(LSConsts.userDataKey);
    if (valueData == null) {
      return UserPreference(
          idUser: null, isLogged: false, isDarkModeOn: false, userName: '');
    } else {
      return UserPreference.fromJson(jsonDecode(valueData));
    }
  }
}
