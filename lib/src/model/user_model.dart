class User {
  String userId;
  String name;
  String email;
  String phone;
  String type;
  String token;
  String renewalToken;

  User(
      {required this.userId,
      required this.name,
      required this.email,
      required this.phone,
      required this.type,
      required this.token,
      required this.renewalToken});

  ///convert to json
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'email': email,
        'phone': phone,
        'type': type,
        'token': token,
        'renewalToken': renewalToken
      };

  ///Constructor from json
  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData['userId'],
      name: responseData['name'],
      email: responseData['email'],
      phone: responseData['phone'],
      type: responseData['type'],
      token: responseData['token'],
      renewalToken: responseData['renewalToken'],
    );
  }
}
