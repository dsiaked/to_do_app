import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({super.key});

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(60.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage('assets/profile1.png'),
                ),
                SizedBox(width: 100.0),
                Text(
                  '지유',
                  style: GoogleFonts.jua(
                    fontSize: 25.0,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),

            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey[300]!),
                      color: const Color.fromARGB(255, 88, 189, 236),
                    ),
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('0', style: GoogleFonts.jua(fontSize: 30.0)),
                        SizedBox(height: 20.0),
                        Text('완료된 작업'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey[300]!),
                      color: const Color.fromARGB(255, 88, 189, 236),
                    ),
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('0', style: GoogleFonts.jua(fontSize: 30.0)),
                        SizedBox(height: 20.0),
                        Text('대기중인 작업'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
