import 'package:flutter/material.dart';
import 'package:flutter_application_2/common/bottomnavbar.dart';
import 'package:flutter_application_2/common/menudrawer.dart';

class MeritScreen extends StatefulWidget {
  const MeritScreen({super.key});

  @override
  State<MeritScreen> createState() => _MeritScreenState();
}

class _MeritScreenState extends State<MeritScreen> {
  bool isEconomySelected = true;
  bool isBussinessSelected = false;
  late List<bool> isSelectedFlags;
  TextEditingController tecPrice = TextEditingController();

  String hintMessageForInterOLev = "";
  String computedMerit = "";

  @override
  void initState() {
    isSelectedFlags = [isEconomySelected, isBussinessSelected];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isEconomySelected) {
      hintMessageForInterOLev = "Please Enter number of Tickets";
    } else {
      hintMessageForInterOLev = "Please Enter number of Tickets";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Tickets"),
        backgroundColor: Color.fromARGB(255, 35, 127, 202),
      ),
      drawer: MenuDrawer(),
      bottomNavigationBar: MyBottomNavBar(),
      body: Column(
        children: [
          Center(
            child: ToggleButtons(
              children: [Text(" Economy "), Text(" Bussiness ")],
              isSelected: isSelectedFlags,
              onPressed: (index) {
                switch (index) {
                  case 0:
                    isEconomySelected = true;
                    isBussinessSelected = false;
                    break;
                  case 1:
                    isEconomySelected = false;
                    isBussinessSelected = true;
                  default:
                }

                setState(() {
                  isSelectedFlags = [isEconomySelected, isBussinessSelected];
                });
              },
            ),
          ),
          TextField(
            decoration: InputDecoration(hintText: hintMessageForInterOLev),
            keyboardType: TextInputType.number,
            controller: tecPrice,
           
          ),
          ElevatedButton(
              onPressed: onMeritButtonPress, child: Text("Calculate Price")),
          Text(computedMerit)
        ],
      ),
    );
  }

  void onMeritButtonPress() {
    double merit = 0;
    if (isEconomySelected) {
      double Tickets = double.tryParse(tecPrice.text) ?? 0;

      merit = Tickets * 22000;
    } else {
      double Tickets = double.tryParse(tecPrice.text) ?? 0;

      merit = Tickets * 40000;
    }

    setState(() {
      computedMerit = "Total price is Rs: " + merit.toStringAsFixed(0);
    });
  }
}
