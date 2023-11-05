import 'package:flutter/material.dart';
import 'package:horario_corte_luz/architecture/datasource/UserPreferenceDatasourceFactory.dart';
import 'package:horario_corte_luz/architecture/repository/UserPreferenceRepositoryImpl.dart';

class UserThemeNotifier with ChangeNotifier {
  bool isDarkModeOn = false;
  bool isLogged;
  String userName;

  UserThemeNotifier(
      {this.isDarkModeOn = false, this.userName = '', this.isLogged = false});

  Future<void> getUserThemePreference() async {
    //Aquí implementamos la lógica de negocio
    // El cliente hizo login
    final userPreference = await UserPreferenceRepositoryImpl(
            userPreferenceDatasource:
                UserPreferenceDatasourceFactory.userPreferenceDatasource(
                    lSData: true))
        .getUserPreference();
    final isCellPhoneDarkMode =
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;

    if (userPreference.isLogged) {
      isDarkModeOn = userPreference.isDarkModeOn ?? isCellPhoneDarkMode;
      isLogged = userPreference.isLogged;
      userName = userPreference.userName;
    } else {
      isLogged = false;
      isDarkModeOn = isCellPhoneDarkMode;
    }
    //TODO: Obtener el tema que escogió el cliente

    notifyListeners();
  }
}
