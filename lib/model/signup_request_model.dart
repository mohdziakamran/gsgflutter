class SignUpRequestModel {
  String firstName;
  String lastName;
  String email;
  String phone;
  String password;

  SignUpRequestModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.password});

  ///convert to json
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'password': password,
      };

  // ///Constructor from json
  // factory SignUpRequestModel.fromJson(Map<String, dynamic> responseData) {
  //   return SignUpRequestModel(
  //     userId: responseData['userId'],
  //     name: responseData['name'],
  //     email: responseData['email'],
  //     phone: responseData['phone'],
  //     type: responseData['type'],
  //     token: responseData['token'],
  //     renewalToken: responseData['renewalToken'],
  //   );
  // }
}
