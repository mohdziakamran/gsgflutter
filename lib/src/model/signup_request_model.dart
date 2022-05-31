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
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phone,
        'password': password,
        'confirm_password': password
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
