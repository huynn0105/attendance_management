import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'employee.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String? id;
  String no;
  String name;
  String username;
  String password;
  String phoneNumber;
  String? image;
  String? position;
  String? sex;
  String? birth;
  String? address;

  User({
    this.id,
    required this.name,
    required this.no,
    required this.phoneNumber,
    required this.image,
    required this.username,
    required this.password,
    this.birth,
    this.position,
    this.sex,
    this.address,
  }) {
    id ??= const Uuid().v4();
  }

  Map<String, dynamic> get values {
    return {
      'no': no,
      'name': name,
      'image': image,
      'phoneNumber': phoneNumber,
      'birth': birth,
      'position': position,
      'sex': sex,
      'address': address,
      'option': this,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

 
}
