import 'package:dio/dio.dart';
import 'package:horario_corte_luz/architecture/dtos/ErrorResponse.dart';
import 'package:horario_corte_luz/core/consts.dart';
import 'package:horario_corte_luz/domain/datasources/SearchAddressesDatasource.dart';
import 'package:horario_corte_luz/domain/entities/AddressSearch.dart';
import 'package:intl/intl.dart';

class SearchAddressesDatasourceImpl extends SearchAddressesDatasource {
  final dio = Dio();

  @override
  Future<List<AddressSearch>> getAddresses(
      {required String city, required String sector}) async {
    try {
      String searchSectorPath = sector.isEmpty ? "" : "&sector=$sector";
      final response = await dio
          .get('${Consts.baseUrl}/schedules?city=$city$searchSectorPath');
      List<AddressSearch> addresses = [];

      dynamic userValue = response.data["data"];

      userValue.forEach((element) {
        addresses.add(AddressSearch(
            id: element["id"],
            city: element["city"],
            sector: element["sector"],
            schedule: element["schedule"],
            lastUpdate: element["lastUpdate"],
            link: element["link"]));
      });

      print(addresses);
      return addresses;
    } on DioException catch (e) {
      if (e.response != null) {
        throw ErrorResponse(
            status: e.response?.data["status"] ?? false,
            message: e.response?.data["message"] ?? 'Error desconocido');
      } else {
        throw ErrorResponse(
            status: false, message: e.message ?? 'Error desconocido');
      }
    }
  }

  @override
  Future<List<AddressSearch>> getUserAddresses({required int userId}) async {
    try {
      final response =
          await dio.get('${Consts.baseUrl}/users/$userId/schedules');
      List<AddressSearch> addresses = [];
      final newFormat = DateFormat("yyyy-MM-dd");

      dynamic userValue = response.data["data"];
      userValue.forEach((element) {
        dynamic schedule = element["schedule"];
        addresses.add(AddressSearch(
            id: schedule["id"],
            city: schedule["city"],
            sector: element["name"],
            schedule: schedule["schedule"],
            lastUpdate:
                newFormat.format(DateTime.parse(schedule["lastUpdate"])),
            link: schedule["link"]));
      });
      return addresses;
    } on DioException catch (e) {
      if (e.response != null) {
        throw ErrorResponse(
            status: e.response?.data["status"] ?? false,
            message: e.response?.data["message"] ?? 'Error desconocido');
      } else {
        throw ErrorResponse(
            status: false, message: e.message ?? 'Error desconocido');
      }
    }
  }

  @override
  Future<bool> saveLocation(
      {required String name,
      required int scheduleId,
      required int userId}) async {
    try {
      final response = await dio.post(
          '${Consts.baseUrl}/users/$userId/schedules',
          data: {"name": name, "scheduleId": scheduleId});

      print(response);
      return true;
    } on DioException catch (e) {
      if (e.response != null) {
        throw ErrorResponse(
            status: e.response?.data["status"] ?? false,
            message: e.response?.data["message"] ?? 'Error desconocido');
      } else {
        throw ErrorResponse(
            status: false, message: e.message ?? 'Error desconocido');
      }
    }
  }
}
