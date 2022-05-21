// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      name: json['name'] as String,
      no: json['no'] as String,
      phoneNumber: json['phoneNumber'] as String,
      image: json['image'] as String?,
      username: json['username'] as String,
      password: json['password'] as String,
      birth: json['birth'] as String?,
      position: json['position'] as String?,
      sex: json['sex'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'name': instance.name,
      'username': instance.username,
      'password': instance.password,
      'phoneNumber': instance.phoneNumber,
      'image': instance.image,
      'position': instance.position,
      'sex': instance.sex,
      'birth': instance.birth,
      'address': instance.address,
    };
