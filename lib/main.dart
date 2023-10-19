import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_cafe_admin/cafe_item.dart';
import 'package:flutter_cafe_admin/cafe_result.dart';
import 'package:flutter_cafe_admin/oreder.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Navi());
}

class Navi extends StatefulWidget {
  const Navi({super.key});

  @override
  State<Navi> createState() => _NaviState();
}

class _NaviState extends State<Navi> {
  int _index = 1;
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_basket_outlined), label: 'order'),
    const BottomNavigationBarItem(icon: Icon(Icons.addchart), label: 'items'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.chat_rounded), label: 'result'),
  ];
  var pages = [const CafeOreder(), const CafeItem(), const CafeResult()];
  dynamic body;

  @override
  void initState() {
    super.initState();
    body = pages[1];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          currentIndex: _index,
          onTap: (value) {
            setState(() {
              body = pages[value];
              _index = value;
            });
          },
        ),
      ),
    );
  }
}
