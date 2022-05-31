class User {
  String userId;
  String name;
  String email;
  String phone;
  String tokenType;
  String token;
  DateTime expireAt;
  DateTime refreshExpireAt;
  String refreshToken;

  User(
      {required this.userId,
      required this.name,
      required this.email,
      required this.phone,
      required this.tokenType,
      required this.token,
      required this.expireAt,
      required this.refreshToken,
      required this.refreshExpireAt});

  ///convert to json
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'email': email,
        'phone': phone,
        'token_type': tokenType,
        'access_token': token,
        'expire_at': expireAt.toString(),
        'refresh_token': refreshToken,
        'refresh_expire_at': refreshExpireAt.toString()
      };

  ///Constructor from json
  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['userId'],
        name: responseData['name'],
        email: responseData['email'],
        phone: responseData['phone'],
        tokenType: responseData['token_type'],
        expireAt: DateTime.parse(responseData['expire_at']),
        token: responseData['access_token'],
        refreshToken: responseData['refresh_token'],
        refreshExpireAt: DateTime.parse(responseData['refresh_expire_at']));
  }
}
