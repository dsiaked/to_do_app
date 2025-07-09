import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:to_do_list/calender_page.dart';
import 'package:to_do_list/my_info_page.dart';
import 'package:to_do_list/to_do_page.dart';

class ToDoMainPage extends StatefulWidget {
  const ToDoMainPage({super.key});

  @override
  State<ToDoMainPage> createState() => _ToDoMainPageState();
}

class _ToDoMainPageState extends State<ToDoMainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    ToDoPage(),
    CalenderPage(),
    MyInfoPage(),
  ];
  // final 의 역할은 오직 하나, 한 번 할당되면 다시 값을 변경할 수 없다!<- 이거 잘 체크해주기!

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Date : 7 / 8',
          style: GoogleFonts.dmSerifDisplay(fontSize: 35.0, color: Colors.grey),
        ),
        centerTitle: true,
      ),

      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: 'ToDo'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My Info'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType
            .fixed, // 항목 수가 3개 이하일 때 기본 값 + ~~ .shifting <- 이거는 항목이 3개를 초과할 때 기본값이다! 주의해주기!!
        onTap:
            _onItemTapped, // "나중에 호출해줘", 똑똑하게도 스스로 판단하여 함수에게 자동으로 넘겨주면서 호출해 줌!
      ),
    );
  }
}
