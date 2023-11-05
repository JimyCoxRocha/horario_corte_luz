import 'dart:convert';

import 'package:horario_corte_luz/architecture/datasource/SearchAddressesDatasourceImpl.dart';
import 'package:horario_corte_luz/architecture/repository/SearchAddressesRepositoryImpl.dart';
import 'package:horario_corte_luz/core/LSConsts.dart';
import 'package:horario_corte_luz/domain/entities/AddressSearch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressesUseCase {
  AddressesUseCase();

  Future<List<AddressSearch>> getAddresses(
      {required String city, required String sector}) async {
    List<AddressSearch> addressList = await SearchAddressesRepositoryImpl(
            searchAddressesDatasource: SearchAddressesDatasourceImpl())
        .getAddresses(city: city, sector: sector);

    return addressList;
  }

  Future<List<AddressSearch>> getUserAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final valueData = prefs.getString(LSConsts.userDataKey);
    Map<String, dynamic> lsStorage = jsonDecode(valueData!);

    List<AddressSearch> addressList = await SearchAddressesRepositoryImpl(
            searchAddressesDatasource: SearchAddressesDatasourceImpl())
        .getUserAddresses(userId: lsStorage['idUser']);

    return addressList;
  }

  Future<bool> saveLocation(
      {required String name, required int scheduleId}) async {
    final prefs = await SharedPreferences.getInstance();
    final valueData = prefs.getString(LSConsts.userDataKey);
    Map<String, dynamic> lsStorage = jsonDecode(valueData!);

    bool addressList = await SearchAddressesRepositoryImpl(
            searchAddressesDatasource: SearchAddressesDatasourceImpl())
        .saveLocation(
            name: name, scheduleId: scheduleId, userId: lsStorage['idUser']);

    return addressList;
  }
}
