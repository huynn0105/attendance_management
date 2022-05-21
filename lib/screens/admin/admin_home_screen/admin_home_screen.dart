import 'package:attendance_management/models/employee.dart';
import 'package:attendance_management/provider/admin_provider.dart';
import 'package:attendance_management/screens/admin/admin_attendance_screen/admin_attendance_screen.dart';
import 'package:attendance_management/screens/admin/admin_salary_screen/admin_salary_screen.dart';
import 'package:attendance_management/utils/button_utils.dart';
import 'package:attendance_management/utils/form_feild_utils.dart';
import 'package:attendance_management/utils/style_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_data_table/web_data_table.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  late String _sortColumnName;
  late bool _sortAscending;
  int _rowsPerPage = 10;
  late SimpleFontelicoProgressDialog _dialog;
  late TextEditingController controller;
  late AdminProvider _adminProvider;
  @override
  void initState() {
    super.initState();
    _adminProvider = context.read<AdminProvider>();
    controller = TextEditingController();
    _dialog = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    Future.delayed(Duration.zero, () async {
      _dialog.show(message: 'Đợi một lát...');
      await _adminProvider.getUser();
      _dialog.hide();
    });
    _sortColumnName = 'browser';
    _sortAscending = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<AdminProvider>(builder: (_, __, ___) {
              return WebDataTable(
                header: Row(
                  children: [
                    width > 700
                        ? Text(
                            'Danh sách nhân viên',
                            style: TextStyleUtils.medium(20),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(170, 55),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                                  content: _AddUser(),
                                ));
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 28,
                      ),
                      label: Text(
                        'Thêm nhân viên',
                        style: TextStyleUtils.regular(24),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(170, 55),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AdminAttendanceScreen()));
                      },
                      child: Text(
                        'Danh sách chấm công',
                        style: TextStyleUtils.regular(24),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.orange),
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(170, 55),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AdminSalaryScreen()));
                      },
                      child: Text(
                        'Danh sách lương',
                        style: TextStyleUtils.regular(24),
                      ),
                    ),
                  ],
                ),
                source: WebDataTableSource(
                  sortColumnName: _sortColumnName,
                  sortAscending: _sortAscending,
                  columns: [
                    WebDataColumn(
                      name: 'image',
                      label: const SizedBox.shrink(),
                      dataCell: (value) => DataCell(
                        Image.asset(
                          'assets/images/image_avt.png',
                          height: 120,
                          width: 120,
                        ),
                      ),
                    ),
                    WebDataColumn(
                      name: 'no',
                      label: Text(
                        'Mã nhân viên',
                        style: TextStyleUtils.medium(20),
                      ),
                      dataCell: (value) => DataCell(Text(
                        '$value',
                        style: TextStyleUtils.regular(20),
                      )),
                    ),
                    WebDataColumn(
                      name: 'name',
                      label: Text(
                        'Tên khách hàng',
                        style: TextStyleUtils.medium(20),
                      ),
                      dataCell: (value) => DataCell(Text(
                        '$value',
                        style: TextStyleUtils.regular(20),
                      )),
                    ),
                    WebDataColumn(
                      name: 'sex',
                      label: Text(
                        'Giới tính',
                        style: TextStyleUtils.medium(20),
                      ),
                      dataCell: (value) => DataCell(Text(
                        '$value',
                        style: TextStyleUtils.regular(20),
                      )),
                    ),
                    WebDataColumn(
                      name: 'birth',
                      label: Text(
                        'Ngày sinh',
                        style: TextStyleUtils.medium(20),
                      ),
                      dataCell: (value) => DataCell(Text(
                        '$value',
                        style: TextStyleUtils.regular(20),
                      )),
                    ),
                    WebDataColumn(
                      name: 'position',
                      label: Text(
                        'Vị trí',
                        style: TextStyleUtils.medium(20),
                      ),
                      dataCell: (value) => DataCell(Text(
                        '$value',
                        style: TextStyleUtils.regular(20),
                      )),
                    ),
                    WebDataColumn(
                      name: 'address',
                      label: Text(
                        'Địa chỉ',
                        style: TextStyleUtils.medium(20),
                      ),
                      dataCell: (value) => DataCell(Text(
                        '$value',
                        style: TextStyleUtils.regular(20),
                      )),
                    ),
                    WebDataColumn(
                      name: 'phoneNumber',
                      label: Text(
                        'SĐT',
                        style: TextStyleUtils.medium(20),
                      ),
                      dataCell: (value) => DataCell(Text(
                        '$value',
                        style: TextStyleUtils.regular(20),
                      )),
                    ),
                    WebDataColumn(
                      name: 'option',
                      label: Text(
                        'Tuỳ chọn',
                        style: TextStyleUtils.medium(20),
                      ),
                      sortable: false,
                      dataCell: (value) => DataCell(
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Xác nhận xoá'),
                                    content: const Text(
                                        'Bạn muốn xoá khách hàng này?'),
                                    actions: [
                                      MyButton(
                                          width: 100,
                                          child: const Text(
                                            'Huỷ bỏ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                          color: Colors.grey,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      MyButton(
                                          width: 100,
                                          child: const Text(
                                            'Xoá',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          color: const Color(0xFFEA2027),
                                          onPressed: () async {
                                            _dialog.show(
                                                message: 'Chờ một lát...');
                                            await _adminProvider
                                                .deleteUserFirebase(
                                                    (value as User).id!);
                                            _dialog.hide();
                                            Navigator.pop(context);
                                          }),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(
                                CupertinoIcons.delete,
                                size: 30,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  rows: _adminProvider.usersToDisplay
                      .map((e) => e.values)
                      .toList(),
                  onTapRow: (rows, index) {
                    print('onTapRow(): index = $index, row = ${rows[index]}');

                    // _viewModel.currentCustomer = rows[index]['customer'];
                    // Get.toNamed(
                    //   MyRouter.detail,
                    //   arguments: _viewModel.currentCustomer,
                    // );
                  },
                  primaryKeyName: 'name',
                ),
                horizontalMargin: 30,
                columnSpacing: (width / 7 - 96) < 0 ? 0 : (width / 7 - 190),
                onPageChanged: (offset) {
                  print('onPageChanged(): offset = $offset');
                },
                onSort: (columnName, ascending) {
                  print(
                      'onSort(): columnName = $columnName, ascending = $ascending');
                  setState(() {
                    _sortColumnName = columnName;
                    _sortAscending = ascending;
                  });
                },
                dataRowHeight: 120,
                headingRowHeight: 70,
                onRowsPerPageChanged: (rowsPerPage) {
                  print('onRowsPerPageChanged(): rowsPerPage = $rowsPerPage');
                  setState(() {
                    if (rowsPerPage != null) {
                      _rowsPerPage = rowsPerPage;
                    }
                  });
                },
                rowsPerPage: _rowsPerPage,
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _AddUser extends StatefulWidget {
  const _AddUser({
    Key? key,
  }) : super(key: key);

  @override
  State<_AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<_AddUser> {
  late TextEditingController _username,
      _name,
      _phoneNumber,
      _position,
      _birth,
      _address;
  late AdminProvider adminProvider;

  late SimpleFontelicoProgressDialog _dialog;

  List<String> gender = ["Nam", "Nữ", "Khác"];

  String? select;

  @override
  void initState() {
    _username = TextEditingController();
    _name = TextEditingController();
    _phoneNumber = TextEditingController();
    _position = TextEditingController();
    _birth = TextEditingController();
    _address = TextEditingController();
    select = gender.first;
    adminProvider = context.read<AdminProvider>();
    _dialog = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Row addRadioButton() {
      return Row(
        children: List.generate(
            gender.length,
            (index) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<String>(
                        value: gender[index],
                        groupValue: select,
                        onChanged: (value) {
                          setState(() {
                            select = value!;
                            print(select);
                          });
                        }),
                    Text(gender[index]),
                    const SizedBox(width: 10),
                  ],
                )),
      );
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              const Text(
                'Thêm nhân viên mới',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.highlight_remove,
                  color: Colors.grey,
                  size: 35,
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 30),
          MyTextFormField(
            width: 620,
            lable: 'Tên đăng nhập',
            controller: _username,
          ),
          const SizedBox(height: 10),
          MyTextFormField(
            width: 620,
            lable: 'Họ và tên',
            controller: _name,
          ),
          const SizedBox(height: 10),
          MyTextFormField(
            width: 620,
            lable: 'Số điện thoại',
            controller: _phoneNumber,
          ),
          const SizedBox(height: 10),
          MyTextFormField(
            width: 620,
            lable: 'Chức vụ',
            controller: _position,
          ),
          const SizedBox(height: 10),
          MyTextFormField(
            width: 620,
            lable: 'Địa chỉ',
            controller: _address,
          ),
          const SizedBox(height: 10),
          MyTextFormField(
            width: 620,
            lable: 'Ngày sinh',
            controller: _birth,
            suffixIcon: const Icon(Icons.calendar_month),
            readOnly: true,
            onTap: () async {
              DateTime? birth = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980, 1, 1),
                lastDate: DateTime.now(),
              );
              if (birth != null) {
                _birth.text = DateFormat('dd/MM/yyyy').format(birth);
              }
            },
          ),
          const SizedBox(height: 10),
          addRadioButton(),
          const SizedBox(height: 15),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                child: Text(
                  'Huỷ bỏ',
                  style: TextStyleUtils.regular(20),
                ),
                width: 150,
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.grey,
              ),
              const SizedBox(width: 20),
              MyButton(
                child: Text(
                  'Thêm',
                  style: TextStyleUtils.regular(20),
                ),
                width: 150,
                onPressed: () async {
                  _dialog.show(message: 'Đang tạo nhân viên mới');
                  await adminProvider.putUserFirebase(
                    User(
                      no: '',
                      name: _name.text,
                      phoneNumber: _phoneNumber.text,
                      image: '',
                      username: _username.text,
                      password: _username.text,
                      address: _address.text,
                      birth: _birth.text,
                      position: _position.text,
                      sex: select,
                    ),
                  );
                  _dialog.hide();
                  Navigator.pop(context);
                },
                color: const Color(0xFF00b90a),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
