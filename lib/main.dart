import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/after_login.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(ToDo());

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do List',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MyPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),

      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          // 얘 아래에는 column이 있다면 그 안에 expanded 사용하지 말기!, sizedbox 사용해주기, 오버플로우 발생한다!
          // or 얘를 최상위에 배치해야 한다, 얘가 최상위에 있어야지 오버플로우 없이 돌아감!
          child: Padding(
            padding: const EdgeInsetsGeometry.only(top: 150.0),
            child: Column(
              children: [
                Text(
                  'To_do List!',
                  style: GoogleFonts.dmSerifDisplay(
                    fontSize: 40.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 70.0),
                Form(
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Colors.teal,
                      inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: Colors.teal,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: controller,
                            decoration: InputDecoration(labelText: 'ID'),
                            keyboardType: TextInputType.emailAddress,
                          ),

                          TextField(
                            controller: controller2,
                            decoration: InputDecoration(labelText: 'password'),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          SizedBox(height: 30.0),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(100, 50),
                            ),
                            onPressed: () {
                              if (controller.text == 'dice' &&
                                  controller2.text == '1234') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ToDoMainPage(),
                                  ),
                                );
                              } else if (controller.text != 'dice' &&
                                  controller2.text == '1234') {
                                _flutterToast('아이디가 틀렸음!');
                              } else if (controller.text == 'dice' &&
                                  controller2.text != '1234') {
                                _flutterToast('비밀번호가 틀렸음!');
                              } else {
                                _flutterToast('둘 다 틀렸음');
                              }
                            },
                            child: Icon(Icons.arrow_forward_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _flutterToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
