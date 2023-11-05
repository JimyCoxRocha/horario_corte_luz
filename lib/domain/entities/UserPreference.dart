class UserPreference {
  final String userName;
  final bool isLogged;
  final bool? isDarkModeOn;
  final int? idUser;

  UserPreference({
    required this.userName,
    required this.isLogged,
    required this.isDarkModeOn,
    required this.idUser,
  });

  String toJson() =>
      '{"userName": "$userName", "isLogged": $isLogged, "isDarkModeOn": $isDarkModeOn, "idUser": $idUser}';

  UserPreference.fromJson(Map<String, dynamic> json)
      : userName = json['userName'] as String,
        idUser = json['idUser'],
        isLogged = true,
        isDarkModeOn = null;
}
