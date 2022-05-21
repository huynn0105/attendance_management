import 'package:attendance_management/models/attendance.dart';
import 'package:attendance_management/models/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class HomeProvider with ChangeNotifier {
  User? currentUser;

  List<User> _usersToDisplay = [];
  Attendance? attendance;

  CollectionReference attandances =
      FirebaseFirestore.instance.collection('attandances');

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void logout() {
    _usersToDisplay.clear();
    attendance = null;
    currentUser = null;
  }

  Future<bool> login(String username, String password) async {
    await getUser();
    attendance = null;
    var users = _usersToDisplay
        .where((x) => x.username == username && x.password == password);
    if (users.isNotEmpty) {
      currentUser = users.first;

      await _getAttendances();
      return true;
    }
    return false;
  }

  Future<void> _getAttendances() async {
    var data1 = await attandances.get();
    var _attendances = data1.docs
        .map((e) => Attendance.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    DateTime today = DateTime.now();
    List<Attendance> _attendancesToDay = _attendances
        .where((x) =>
            (x.timeStart!.millisecondsSinceEpoch >=
                DateTime(today.year, today.month, today.day, 0, 0, 0)
                    .millisecondsSinceEpoch) &&
            currentUser!.id == x.employeeId)
        .toList();
    if (_attendancesToDay.isNotEmpty) {
      _attendancesToDay.sort((a, b) => a.createTime!.compareTo(b.createTime!));
      attendance = _attendancesToDay.first;
    }
  }

  Future<void> getUser() async {
    var data = await users.get();

    _usersToDisplay = data.docs
        .map((e) => User.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }

  FirebaseStorage firebaseStorageRef = FirebaseStorage.instance;

  Future<void> putAttendance(Attendance attendance) async {
    await attandances.doc(attendance.id).set(attendance.toJson());
  }

  Future<void> onEnd() async {
    attendance!.timeEnd = DateTime.now();
    attendance!.status = 'Đã kết thúc ca làm';
    await putAttendance(attendance!);
    notifyListeners();
  }

  Future<void> onStart() async {
    try {
      var pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front);

      print('path: ${pickedFile?.path}');
      if (pickedFile != null) {
        String fileName = basename(pickedFile.path);

        TaskSnapshot taskSnapshot = await firebaseStorageRef
            .ref()
            .child('upload/$fileName')
            .putData(await pickedFile.readAsBytes());

        String url = await taskSnapshot.ref.getDownloadURL();

        attendance = Attendance(
          employeeId: currentUser!.id!,
          id: const Uuid().v4(),
          image: url,
          name: currentUser!.name,
          status: 'Đang làm',
          timeStart: DateTime.now(),
          timeEnd: null,
          no: currentUser!.no,
        );
        notifyListeners();
        await putAttendance(attendance!);
        print(url);
      } else {}
    } catch (e) {
      print('lỗi ${e.toString()}');
    }
    notifyListeners();
  }
}
