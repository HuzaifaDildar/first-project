import 'package:flutter/material.dart';
import 'package:flutter_application_2/common/bottomnavbar.dart';
import 'package:flutter_application_2/common/menudrawer.dart';
import 'package:flutter_application_2/weather/http_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../weather/weather.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  HttpHelper httpHelper = HttpHelper();
  String weatherInfo = "";
  Weather weatherData = Weather("", 0, 0, 0.0, 0, "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    httpHelper
        .getWeatherofGCU("74.3078585", "31.573152")
        .then((weatherObj) {
      weatherData = weatherObj;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Info of GCU"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(children: [
        TextField(
          decoration: InputDecoration(
              hintText: "Please Enter the City Name",
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )),
        ),
        createAWeatherRow("Temperature", weatherData.temperature.toStringAsFixed(3)),
        createAWeatherRow("Description", weatherData.description),
        createAWeatherRow("City Name", weatherData.cityName),
        createAWeatherRow("Cloud Cover", weatherData.cloudCover.toString()),
        createAWeatherRow("Wind Speed", weatherData.windSpeed.toStringAsFixed(3)),
        createAWeatherRow("Humidity", weatherData.humidity.toString()),
        ElevatedButton(
            onPressed: () async {
              Location locationObj = Location();
              bool gpsStatus = await locationObj.serviceEnabled();

              if (gpsStatus == false) {
                gpsStatus = await locationObj.requestService();
              }
              if (gpsStatus == false) {
                return;
              }
              PermissionStatus permissionStatus =
                  await locationObj.hasPermission();

              if (permissionStatus != PermissionStatus.granted) {
                permissionStatus = await locationObj.requestPermission();
              }
              if (permissionStatus != PermissionStatus.granted) {
                return;
              }

              var location = await locationObj.getLocation();

              double lat = location.latitude ?? 31.573152;
              double lng = location.longitude ?? 74.3078585;
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(title: Text("GCU Map View")),
                    body: GoogleMap(
                        mapType: MapType.normal,
                        markers: {
                          Marker(
                              markerId: MarkerId("1"),
                              position: LatLng(lat, lng),
                              infoWindow:
                                  InfoWindow(title: "GCU", snippet: "Uni"))
                        },
                        initialCameraPosition:
                            CameraPosition(target: LatLng(lat, lng), zoom: 15)),
                  );
                },
              ));
            },
            child: const Text("View on Map"))
      ]),
    );
  }

  Widget createAWeatherRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Text(
                label,
                style:
                    TextStyle(fontSize: 25, color: Theme.of(context).hintColor),
              )),
          Expanded(
              flex: 6,
              child: Text(value,
                  style: TextStyle(
                      fontSize: 25, color: Theme.of(context).primaryColor))),
        ],
      ),
    );
  }
}



// class AboutUs extends StatefulWidget {
//   const AboutUs({super.key});

//   @override
//   State<AboutUs> createState() => _AboutUsState();
// }

// class _AboutUsState extends State<AboutUs> {
//   String weatherInfo = "";
//   Weather weather = Weather("", 0, 0, 0, 0, "");
//   HttpHelper httpHelper = HttpHelper();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     httpHelper.getWeatherofGCU("31.573152", "74.3078585").then((weatherObj) {
//       weather = weatherObj;
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Weather Info"),
//         backgroundColor: Color.fromARGB(255, 35, 127, 202),
//       ),
//       drawer: MenuDrawer(),
//       bottomNavigationBar: MyBottomNavBar(),
//       body: Column(
//         children: [
//           TextField(
//             decoration: InputDecoration(
//                 hintText: "Please Enter the name of city",
//                 suffixIcon:
//                     IconButton(icon: Icon(Icons.search), onPressed: () {})),
//           ),
//           createAWeatherRow("City Name", weather.cityName),
//           createAWeatherRow("Temperature", weather.temperature.toStringAsFixed(3)),
//           createAWeatherRow("Wind Speed", weather.windSpeed.toString()),
//           createAWeatherRow("Cloud Cover", weather.cloudCover.toString()),
//           createAWeatherRow("Humidity", weather.humidity.toString()),
//           createAWeatherRow("Desciption", weather.description)
//         ],
//       ),
//     );
//   }

//   Widget createAWeatherRow(String key, String value) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//               flex: 4,
//               child: Text(key,
//                   style: TextStyle(
//                       fontSize: 22, color: Theme.of(context).hintColor))),
//           Expanded(
//               flex: 7,
//               child: Text(value,
//                   style: TextStyle(
//                       fontSize: 22, color: Theme.of(context).primaryColor))),
//         ],
//       ),
//     );
//   }
// }

























// import 'package:flutter/material.dart';
// import 'package:flutter_application_2/weather/http_helper.dart';
// import '../weather/weather.dart';
// import 'package:flutter_application_2/common/bottomnavbar.dart';
// import 'package:flutter_application_2/common/menudrawer.dart';

// class AboutUs extends StatefulWidget {
//   const AboutUs({super.key});

//   @override
//   State<AboutUs> createState() => _AboutUsState();
// }

// class _AboutUsState extends State<AboutUs> {
//   String weatherInfo = "";
//   Weather weather = Weather("", 0, 0, 0, 0, "");
//   HttpHelper httpHelper = HttpHelper();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     httpHelper.GetWeatherofGCU("31.573152", "74.3078585").then((weatherObj) {
//       weather = weatherObj;
//       weatherInfo = weather.description;
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Weather Info"),
//         backgroundColor: Color.fromARGB(255, 35, 127, 202),

//       ),
//       drawer: MenuDrawer(),
//       bottomNavigationBar: MyBottomNavBar(),
//       body: Center(child: Text(weatherInfo)),
//     );
//   }
// }



















// import 'package:flutter/material.dart';
// import '../common/menudrawer.dart';
// import "../common/bottomnavbar.dart";

// class AboutUSScreen extends StatefulWidget {
//   const AboutUSScreen({super.key});

//   @override
//   State<AboutUSScreen> createState() => _AboutUSScreenState();
// }

// class _AboutUSScreenState extends State<AboutUSScreen> {
//   String message = "";
//   TextEditingController tecName = TextEditingController();
//   late int counter;

//   @override
//   void initState() {
//     counter = 0;
   
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("About us"),
//            backgroundColor: Color.fromARGB(255, 35, 127, 202),
//         ),
//          drawer: MenuDrawer(),
//          bottomNavigationBar: MyBottomNavBar(),
//         body: Column(
//           children: [
//             TextField(
//               controller: tecName,
//               decoration: InputDecoration(hintText: "Please enter your name"),
//             ),
//             Center(
//               child: ElevatedButton(
//                   onPressed: onButtonPress, child: Text("Click here!")),
//             ),
//             Text(message)
//           ],
//         ));
//   }

//   void onButtonPress() {
//     setState(() {
//       counter = counter + 1;
//       message = "Welcome " +
//           tecName.text +
//           " your request has been recieved  " +
//           counter.toString() +
//           " time";
//     });
//   }
// }


