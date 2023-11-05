import 'package:horario_corte_luz/domain/entities/AddressSearch.dart';

abstract class SearchAddressesDatasource {
  Future<List<AddressSearch>> getAddresses(
      {required String city, required String sector});

  Future<List<AddressSearch>> getUserAddresses({required int userId});

  Future<bool> saveLocation(
      {required String name, required int scheduleId, required int userId});
}
