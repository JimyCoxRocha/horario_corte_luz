import 'package:horario_corte_luz/domain/datasources/SearchAddressesDatasource.dart';
import 'package:horario_corte_luz/domain/entities/AddressSearch.dart';
import 'package:horario_corte_luz/domain/repository/SearchAddressesRepository.dart';

class SearchAddressesRepositoryImpl extends SearchAddressesRepository {
  final SearchAddressesDatasource searchAddressesDatasource;

  SearchAddressesRepositoryImpl({required this.searchAddressesDatasource});

  @override
  Future<List<AddressSearch>> getAddresses(
      {required String city, required String sector}) {
    return searchAddressesDatasource.getAddresses(city: city, sector: sector);
  }

  @override
  Future<bool> saveLocation(
      {required String name, required int scheduleId, required int userId}) {
    return searchAddressesDatasource.saveLocation(
        name: name, scheduleId: scheduleId, userId: userId);
  }

  @override
  Future<List<AddressSearch>> getUserAddresses({required int userId}) {
    return searchAddressesDatasource.getUserAddresses(userId: userId);
  }
}
