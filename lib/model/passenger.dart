import 'package:gsgflutter/passenger_details/gender.dart';

class Passanger {
  String name;
  int age;
  Gender gender;

  Passanger(this.name, this.age, this.gender);

  Passanger.fromJson(Map<String, dynamic> responseData)
      : name = responseData['name'],
        age = int.parse(responseData['age'] as String),
        gender =
            (responseData['gender'] == 'MALE') ? Gender.MALE : Gender.FEMALE;
}
