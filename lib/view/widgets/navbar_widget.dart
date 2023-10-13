import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.white,
        fixedColor: Colors.blue,
        selectedFontSize: 12,
        unselectedFontSize: 30,
        showSelectedLabels: true,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: "Loans"),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_note_rounded), label: "Contracts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined), label: "Teams"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined), label: "Chat")
        ]);
  }
}
