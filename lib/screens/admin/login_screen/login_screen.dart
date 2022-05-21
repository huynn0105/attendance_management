import 'package:attendance_management/provider/home_provider.dart';
import 'package:attendance_management/screens/admin/admin_home_screen/admin_home_screen.dart';
import 'package:attendance_management/screens/home_screen/home_screen.dart';
import 'package:attendance_management/utils/button_utils.dart';
import 'package:attendance_management/utils/form_feild_utils.dart';
import 'package:attendance_management/utils/style_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late HomeProvider _homeProvider;
  late SimpleFontelicoProgressDialog _dialog;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    _homeProvider = context.read<HomeProvider>();
    _dialog = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFedf0f5),
      body: kIsWeb
          ? Center(
              child: SizedBox(
                height: 600,
                width: 600,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Hệ thống quản lý chấm công',
                          style: TextStyleUtils.bold(35)
                              .copyWith(color: Colors.blue),
                        ),
                        MyTextFormField(
                          lable: 'Tên đăng nhập',
                          controller: usernameController,
                        ),
                        MyTextFormField(
                          lable: 'Mật khẩu',
                          controller: passwordController,
                          obscureText: true,
                        ),
                        MyButton(
                          onPressed: () async {
                            _dialog.show(message: 'Đang xử lý');
                            if (usernameController.text == 'admin' &&
                                passwordController.text == 'admin') {
                              _dialog.hide();
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminHomeScreen()));
                            } else {
                              bool result = await _homeProvider.login(
                                  usernameController.text,
                                  passwordController.text);
                              if (result) {
                                _dialog.hide();
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              } else {
                                _dialog.hide();
                                await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      'Tên đăng nhập hoặc mật khẩu không chính xác!',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    actions: [
                                      MyButton(
                                        child: const Text(
                                          'Xác nhận',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        width: 120,
                                        height: 60,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        color: const Color(0xFFEA2027)
                                            .withOpacity(0.86),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          height: 70,
                          child: const Text(
                            'Đăng nhập',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Text(
                      'Hệ thống quản lý chấm công',
                      style:
                          TextStyleUtils.bold(35).copyWith(color: Colors.blue),
                    ),
                    const SizedBox(height: 24),
                    MyTextFormField(
                      lable: 'Tên đăng nhập',
                      controller: usernameController,
                    ),
                    const SizedBox(height: 24),
                    MyTextFormField(
                      lable: 'Mật khẩu',
                      controller: passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 44),
                    MyButton(
                      onPressed: () async {
                        _dialog.show(message: 'Đang xử lý');
                        if (usernameController.text == 'admin' &&
                            passwordController.text == 'admin') {
                          _dialog.hide();
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminHomeScreen()));
                        } else {
                          bool result = await _homeProvider.login(
                              usernameController.text, passwordController.text);
                          if (result) {
                            _dialog.hide();
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          } else {
                            _dialog.hide();
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                  'Tên đăng nhập hoặc mật khẩu không chính xác!',
                                  style: TextStyle(fontSize: 15),
                                ),
                                actions: [
                                  MyButton(
                                    child: const Text(
                                      'Xác nhận',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    width: 120,
                                    height: 60,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: const Color(0xFFEA2027)
                                        .withOpacity(0.86),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                      height: 70,
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }
}
