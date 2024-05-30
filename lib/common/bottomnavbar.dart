import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // currentIndex: 1,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.add_card), label: "Tickets"),
        BottomNavigationBarItem(icon: Icon(Icons.access_alarms_sharp), label: "Time")
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, "/");
            break;
          case 1:
            Navigator.pushNamed(context, "/merit");
            break;
          default:
        }
      },
    );
  }
}
