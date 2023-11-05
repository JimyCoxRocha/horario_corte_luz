class UserAuthMap {
  final int idUser;
  final String userName;
  final bool? isDarkModeOn;
  final bool isLogged;

  UserAuthMap(
      {required this.idUser,
      required this.userName,
      required this.isDarkModeOn,
      required this.isLogged});

  factory UserAuthMap.fromJson(Map<String, dynamic> json) {
    return UserAuthMap(
        idUser: json['idUser'],
        userName: json['userName'],
        isDarkModeOn: json['isDarkModeOn'] ?? null,
        isLogged: json['isLogged'] ?? true);
  }
}
