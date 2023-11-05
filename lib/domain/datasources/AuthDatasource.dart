import 'package:horario_corte_luz/architecture/dtos/LoginDto.dart';

abstract class AuthDatasource {
  Future<LoginDto> loginUser({required String email, required String password});
  Future<LoginDto> registerUser(
      {required String email,
      required String password,
      required String userName});
}
