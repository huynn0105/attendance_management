import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
part 'attendance.g.dart';

@JsonSerializable(explicitToJson: true)
class Attendance {
  String id;
  String employeeId;
  String no;
  String image;
  String name;
  String status;
  DateTime? timeStart;
  DateTime? timeEnd;
  int? createTime;

  Attendance({
    required this.id,
    required this.employeeId,
    required this.image,
    required this.name,
    required this.status,
    required this.no,
    this.timeStart,
    this.timeEnd,
    this.createTime,
  }) {
    createTime ??= DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic> get values {
    return {
      'no': no,
      'name': name,
      'image': image,
      'status': status,
      'timeStart': timeStart,
      'timeEnd': timeEnd,
    };
  }

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceToJson(this);

  
}
