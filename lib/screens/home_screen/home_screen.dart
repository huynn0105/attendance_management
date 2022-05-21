import 'package:attendance_management/provider/home_provider.dart';
import 'package:attendance_management/screens/admin/login_screen/login_screen.dart';
import 'package:attendance_management/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider homeProvider;
  late SimpleFontelicoProgressDialog _dialog;

  @override
  void initState() {
    homeProvider = context.read<HomeProvider>();
    _dialog = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade300,
        leading: const SizedBox.shrink(),
        title: Text(homeProvider.currentUser!.name),
        actions: [
          IconButton(
            onPressed: () {
              homeProvider.logout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      backgroundColor: Colors.lightBlue.shade300,
      body: Consumer<HomeProvider>(builder: (_, __, snapshot) {
        DateTime currentTime = DateTime.now();
        String? sduration;
        if (homeProvider.attendance != null &&
            homeProvider.attendance!.timeStart != null) {
          if (homeProvider.attendance!.timeEnd == null) {
            currentTime = homeProvider.attendance!.timeStart!;
          } else {
            Duration duration = homeProvider.attendance!.timeEnd!
                .difference(homeProvider.attendance!.timeStart!);
            sduration =
                "${duration.inHours.toString().padLeft(2, "0")}:${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, "0")}";
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ColoredBox(
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Current Time',
                      style: TextStyleUtils.medium(35)
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1)),
                        builder: (context, snapshot) {
                          return Text(
                            DateFormat('HH:mm:ss').format(DateTime.now()),
                            style: TextStyleUtils.bold(70)
                                .copyWith(color: Colors.white),
                          );
                        }),
                    const SizedBox(height: 5),
                    Text(
                      DateFormat('dd MMM yyyy').format(
                        DateTime.now(),
                      ),
                      style: TextStyleUtils.medium(25)
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  homeProvider.attendance == null
                      ? Text('00:00:00',
                          style: TextStyleUtils.bold(50)
                              .copyWith(color: Colors.white))
                      : homeProvider.attendance!.timeStart != null &&
                              homeProvider.attendance!.timeEnd == null
                          ? StreamBuilder(
                              stream:
                                  Stream.periodic(const Duration(seconds: 1)),
                              builder: (context, snapshot) {
                                Duration duration =
                                    DateTime.now().difference(currentTime);
                                String sDuration =
                                    "${duration.inHours.toString().padLeft(2, "0")}:${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${(duration.inSeconds.remainder(60)).toString().padLeft(2, "0")}";

                                return Text(sDuration,
                                    style: TextStyleUtils.bold(50)
                                        .copyWith(color: Colors.white));
                              })
                          : Text(
                              sduration ?? '00:00:00',
                              style: TextStyleUtils.bold(50)
                                  .copyWith(color: Colors.white),
                            ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () async {
                      if (homeProvider.attendance != null &&
                          homeProvider.attendance!.timeStart != null &&
                          homeProvider.attendance!.timeEnd == null) {
                        _dialog.show(message: 'Đang xử lý');
                        await homeProvider.onEnd();
                        _dialog.hide();
                      } else {
                        _dialog.show(message: 'Đang xử lý');
                        await homeProvider.onStart();
                        _dialog.hide();
                      }
                    },
                    child: Text(
                      (homeProvider.attendance != null &&
                              homeProvider.attendance!.timeStart != null &&
                              homeProvider.attendance!.timeEnd == null)
                          ? 'Kết thúc'
                          : 'Bắt đầu',
                      style: TextStyleUtils.regular(30)
                          .copyWith(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          homeProvider.attendance != null &&
                                  homeProvider.attendance!.timeStart != null &&
                                  homeProvider.attendance!.timeEnd == null
                              ? Colors.red.shade700
                              : Colors.blue.shade700),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Lịch trình hôm nay',
                    style:
                        TextStyleUtils.medium(30).copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 5,
                            color: Colors.white,
                          ),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text(
                              'Vào ca',
                              style: TextStyleUtils.medium(20)
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              (homeProvider.attendance != null &&
                                      homeProvider.attendance!.timeStart !=
                                          null)
                                  ? DateFormat('HH:mm').format(
                                      homeProvider.attendance!.timeStart!)
                                  : '_ _:_ _',
                              style: TextStyleUtils.medium(25)
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 5,
                            color: Colors.white,
                          ),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text(
                              'Kết ca',
                              style: TextStyleUtils.medium(20)
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              (homeProvider.attendance != null &&
                                      homeProvider.attendance!.timeEnd != null)
                                  ? DateFormat('HH:mm')
                                      .format(homeProvider.attendance!.timeEnd!)
                                  : '_ _:_ _',
                              style: TextStyleUtils.medium(25)
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
