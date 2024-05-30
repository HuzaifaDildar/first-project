import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/homescreen.dart';
import 'package:flutter_application_2/screens/meritscreen.dart';
import 'package:flutter_application_2/screens/aboutus.dart';
import 'package:flutter_application_2/screens/sportsscreen.dart';
import 'package:flutter_application_2/screens/sportsscreen_firebase.dart';
// import 'package:flutter_application_2/screens/sportsscreen_sqlite.dart';
import 'package:flutter_application_2/screens/sportsscreen_sqlite.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(

            child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Huzaifa Dildar'),
            accountEmail: const Text('huzaifadildar1@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset('profile.jpg')),
            ),
          ),
        ListTile(
          title: Text("Home"),
          onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen())),
        ),
        Divider(),
         ListTile(
          title: Text("Bookings Tickets"),
          onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MeritScreen())),
        ),
        Divider(),
         ListTile(
          title: Text("Flight Schedule"),
          onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SportsScreen())),
        ),
        Divider(),

        ListTile(
          title: Text("SQFlite"),
          onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SportsScreenFirebase())),
        ),
        Divider(),

         ListTile(
          title: Text("FireBase"),
          onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SportsScreenSQlite())),
        ),

        Divider(),
            ListTile(
          title: Text("About"),
          onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>AboutUsScreen())),
        ),
        Divider(),
        

        ],
      ),
   
    );
    
   
    
  }
}


             

//   List<Widget> buildMenuItems(BuildContext context) {
//     List<Widget> menuItems = [];

//     menuItems.add(const DrawerHeader(
//         child: Text(
//       "Qatar Airways Booking Center",
//       style: TextStyle(fontSize: 30),
//     )));

//     final Set<String> menuTitles = {
//       "Home",
//       "Book Tickets",
//       "Track Flight",
//       "About"
//     };

//     menuTitles.forEach((element) {
//       menuItems.add(ListTile(
//         title: Text(element, style: TextStyle(fontSize: 20)),
//         onTap: () {
//           Widget screen = Container();

//           switch (element) {
//             case 'Home':
//               screen = const HomeScreen();
//               break;
//             case 'Book Tickets':
//               screen = const MeritScreen();
//               break;
//             default:
//           }

//           Navigator.of(context).pop();
//           Navigator.of(context)
//               .push(MaterialPageRoute(builder: (context) => screen));
//         },
//       ));
//     });
//     return menuItems;
//   }
// }







  // backgroundColor: const Color.fromARGB(255, 254, 254, 254),
  //     child: ListView(
  //       children: [
  //         UserAccountsDrawerHeader(
  //           accountName: const Text('Huzaifa Dildar'),
  //           accountEmail: const Text('huzaifadildar1@gmail.com'),
  //           currentAccountPicture: CircleAvatar(
  //             child: ClipOval(child: Image.asset('unnamed.jpg')),
  //           ),
  //         ),
  //       ListView(children: buildMenuItems(context)),
  //       ],
  //     )
  //