import 'package:flutter/material.dart';
import '../common/menudrawer.dart';
import "../common/bottomnavbar.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qatar AirWays"),
        backgroundColor: Color.fromARGB(255, 35, 127, 202),
      ),
      drawer: MenuDrawer(),
      bottomNavigationBar: MyBottomNavBar(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("air.jpg"), fit: BoxFit.fill)),
        child: Center(
            child: Container(
          padding: EdgeInsets.all(10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color.fromARGB(179, 230, 221, 221)),
          child: const Text(
            "Lets fly with Qatar Airways",
            style: TextStyle(fontSize: 20),
          ),
        )),
      ),
    );
  }
}

// class MyBottomNavBar extends StatelessWidget {
//   const MyBottomNavBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(items: [
//       BottomNavigationBarItem(icon: Icon(Icons.home), label:"Home"),
//        BottomNavigationBarItem(icon: Icon(Icons.add_alarm_sharp), label:"Merit Screen"),
//     ],
//     onTap: (index){
//       switch (index){
//         case 0:
//         // Navigator.pushNamed(context, HomeScreen())
//         break;
//         case 1:
//         break;
//       }
//     },
//     );
//   }
// }
