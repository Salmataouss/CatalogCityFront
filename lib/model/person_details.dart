import 'dart:convert';

PersonDetails personFromJson(String str) =>
    PersonDetails.fromJson(json.decode(str));

Map personToJson(PersonDetails person) => person.toJson();

class PersonDetails {
  String? name;
  String email;
  String? imageUrl;
  String? password;
  String? phoneNumber;
  String? dob;

  PersonDetails(
      {this.name,
      required this.email,
      this.password,
      this.phoneNumber,
      this.dob,
      this.imageUrl});

  factory PersonDetails.fromJson(Map<String, dynamic> json) => PersonDetails(
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        dob: json['dob'],
        imageUrl: json['imageUrl'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name ?? ' ';
    data['email'] = email;
    data['password'] = password;
    data['imageUrl'] = imageUrl ?? '';
    // data['phoneNumber'] = phoneNumber;
    // data['dob'] = dob;
    return data;
  }
}
