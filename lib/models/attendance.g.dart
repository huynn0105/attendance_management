// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      image: json['image'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      no: json['no'] as String,
      timeStart: json['timeStart'] == null
          ? null
          : DateTime.parse(json['timeStart'] as String),
      timeEnd: json['timeEnd'] == null
          ? null
          : DateTime.parse(json['timeEnd'] as String),
      createTime: json['createTime'] as int?,
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'no': instance.no,
      'image': instance.image,
      'name': instance.name,
      'status': instance.status,
      'timeStart': instance.timeStart?.toIso8601String(),
      'timeEnd': instance.timeEnd?.toIso8601String(),
      'createTime': instance.createTime,
    };
