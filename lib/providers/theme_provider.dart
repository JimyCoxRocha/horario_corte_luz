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
                UserPreferenceDatasourceFactory.userPreferenceDatasource())
        .getUserPreference();

    if (userPreference.isLogged) {
      isDarkModeOn = userPreference.isDarkModeOn;
      isLogged = userPreference.isLogged;
      userName = userPreference.userName;
    } else {
      isLogged = false;
      isDarkModeOn =
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark;
    }
    //TODO: Obtener el tema que escogió el cliente

    notifyListeners();
  }
}
