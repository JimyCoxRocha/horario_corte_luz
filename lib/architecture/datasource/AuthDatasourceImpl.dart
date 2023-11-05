import 'package:dio/dio.dart';
import 'package:horario_corte_luz/architecture/dtos/ErrorResponse.dart';
import 'package:horario_corte_luz/architecture/dtos/LoginDto.dart';
import 'package:horario_corte_luz/core/consts.dart';
import 'package:horario_corte_luz/domain/datasources/AuthDatasource.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio();

  @override
  Future<LoginDto> loginUser(
      {required String email, required String password}) async {
    try {
      final response = await dio.post('${Consts.baseUrl}/auth/login', data: {
        'email': email,
        'password': password,
      });
      dynamic userValue = response.data["user"];
      return LoginDto(idUser: userValue["id"], userName: userValue["username"]);
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
  Future<LoginDto> registerUser(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      final response = await dio.post('${Consts.baseUrl}/auth/register', data: {
        'username': userName,
        'email': email,
        'password': password,
      });
      dynamic userValue = response.data["user"];
      return LoginDto(idUser: userValue["id"], userName: userValue["username"]);
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
