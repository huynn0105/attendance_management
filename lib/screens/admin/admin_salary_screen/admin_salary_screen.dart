import 'package:attendance_management/provider/admin_provider.dart';
import 'package:attendance_management/screens/admin/admin_attendance_screen/admin_attendance_screen.dart';
import 'package:attendance_management/screens/admin/admin_home_screen/admin_home_screen.dart';
import 'package:attendance_management/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_data_table/web_data_table.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AdminSalaryScreen extends StatefulWidget {
  const AdminSalaryScreen({Key? key}) : super(key: key);

  @override
  State<AdminSalaryScreen> createState() => _AdminSalaryScreenState();
}

class _AdminSalaryScreenState extends State<AdminSalaryScreen> {
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
      await _adminProvider.getSalary();
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

    return Scaffold(
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
                              builder: (context) => const AdminHomeScreen()));
                    },
                    child: Text(
                      'Danh sách nhân viên',
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
                                  const AdminAttendanceScreen()));
                    },
                    child: Text(
                      'Danh sách chấm công',
                      style: TextStyleUtils.regular(24),
                    ),
                  )
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
                      value != ''
                          ? Image.network(
                              value,
                              height: 150,
                              width: 150,
                            )
                          : Image.asset(
                              'assets/images/image_avt.png',
                              height: 150,
                              width: 150,
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
                      'Tên nhân viên',
                      style: TextStyleUtils.medium(20),
                    ),
                    dataCell: (value) => DataCell(Text(
                      '$value',
                      style: TextStyleUtils.regular(20),
                    )),
                  ),
                  WebDataColumn(
                    name: 'salary',
                    label: Text(
                      'Lương',
                      style: TextStyleUtils.medium(20),
                    ),
                    dataCell: (value) => DataCell(Text(
                      '$value VNĐ',
                      style: TextStyleUtils.regular(20),
                    )),
                  ),
                  WebDataColumn(
                    name: 'type',
                    label: Text(
                      'Loại lương',
                      style: TextStyleUtils.medium(20),
                    ),
                    dataCell: (value) => DataCell(Text(
                      '$value',
                      style: TextStyleUtils.regular(20),
                    )),
                  ),
                  WebDataColumn(
                    name: 'hour',
                    label: Text(
                      'Số giờ làm việc',
                      style: TextStyleUtils.medium(20),
                    ),
                    dataCell: (value) => DataCell(Text(
                      (value as double).toStringAsFixed(2),
                      style: TextStyleUtils.regular(20),
                    )),
                  ),
                  WebDataColumn(
                    name: 'paid',
                    label: Text(
                      'Trả',
                      style: TextStyleUtils.medium(20),
                    ),
                    dataCell: (value) => DataCell(Text(
                      '$value VNĐ',
                      style: TextStyleUtils.regular(20),
                    )),
                  ),
                ],
                rows: _adminProvider.salaries.map((e) => e.values).toList(),
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
              columnSpacing: (width / 7 - 96) < 0 ? 0 : (width / 7 - 146),
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
              dataRowHeight: 150,
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
    );
  }
}
