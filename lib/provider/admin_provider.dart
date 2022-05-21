import 'dart:math';

import 'package:attendance_management/models/attendance.dart';
import 'package:attendance_management/models/employee.dart';
import 'package:attendance_management/models/salary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class AdminProvider with ChangeNotifier {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  CollectionReference attandances =
      FirebaseFirestore.instance.collection('attandances');

  Future<void> putUserFirebase(User entity) async {
    entity.no = '000000' + Random().nextInt(100).toString();
    await users.doc(entity.id).set(entity.toJson());
    await getUser();
  }

  Future<void> deleteUserFirebase(String id) async {
    try {
      await users.doc(id).delete();
      await getUser();
    } catch (e) {}
  }

  final List<Attendance> _attendancesToDisplay = [];
  List<User> _usersToDisplay = [];
  List<Attendance> get attendancesToDisplay => _attendancesToDisplay;
  List<User> get usersToDisplay => _usersToDisplay;

  Future<void> getAttendance() async {
    await getUser();
    var data = await attandances.get();
    _attendancesToDisplay.clear();
    var _attendances = data.docs
        .map((e) => Attendance.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    DateTime today = DateTime.now();
    List<Attendance> _attendancesToDay = _attendances
        .where((x) =>
            x.timeStart!.millisecondsSinceEpoch >=
            DateTime(today.year, today.month, today.day, 0, 0, 0)
                .millisecondsSinceEpoch)
        .toList();

    List<String> _attendancesUserToDayIds =
        _attendancesToDay.map((e) => e.employeeId).toList();

    List<User> usersNotAttendance = _usersToDisplay
        .where((e) => !_attendancesUserToDayIds.contains(e.id))
        .toList();
    List<User> usersAttendanced = _usersToDisplay
        .where((e) => _attendancesUserToDayIds.contains(e.id))
        .toList();

    for (var user in usersAttendanced) {
      for (var attendanceToday in _attendancesToDay) {
        if (attendanceToday.employeeId == user.id) {
          _attendancesToDisplay.add(attendanceToday);
        }
      }
    }

    _attendancesToDisplay.addAll(usersNotAttendance.map((e) => Attendance(
          employeeId: e.id!,
          id: const Uuid().v4(),
          image: '',
          name: e.name,
          status: 'Chưa làm',
          no: e.no,
        )));
    notifyListeners();
  }

  Future<void> getUser() async {
    var data = await users.get();

    _usersToDisplay = data.docs
        .map((e) => User.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  List<Salary> salaries = [];

  Future<void> getSalary() async {
    var data = await users.get();
    salaries.clear();
    var userss = data.docs
        .map((e) => User.fromJson(e.data() as Map<String, dynamic>))
        .toList();

    var data1 = await attandances.get();
    var _attendances = data1.docs
        .map((e) => Attendance.fromJson(e.data() as Map<String, dynamic>))
        .toList();

    for (var user in userss) {
      var attendancesOfUser =
          _attendances.where((x) => x.employeeId == user.id).toList();
      double hour =
          attendancesOfUser.fold<double>(0.0, (previousValue, element) {
        DateTime timeEnd = element.timeEnd ?? DateTime.now();
        Duration dr = timeEnd.difference(element.timeStart!);
        double hour = dr.inMinutes/60;
        return previousValue + hour;
      });
      
      salaries.add(
        Salary(
          no: user.no,
          image: '',
          salary: 30000,
          hour: hour,
          type: 'Giờ',
          paid: 30000 * hour,
          name: user.name,
        ),
      );
    }
    notifyListeners();
  }
}
