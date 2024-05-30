import 'package:flutter/material.dart';
import 'package:flutter_application_2/common/bottomnavbar.dart';
import 'package:flutter_application_2/common/menudrawer.dart';
import 'package:flutter_application_2/data/sharedpref_helper.dart';
import 'package:flutter_application_2/data/sports_entry.dart';

class SportsScreen extends StatefulWidget {
  const SportsScreen({super.key});

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  SharedPrefHelper sharedPrefHelper = SharedPrefHelper();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  List<SportEntry> sportsEntries = [];
  int runningCounter = 1;
  String errorMessage = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPrefHelper.init().then((value) {
      sportsEntries = sharedPrefHelper.getAllofSportsDate();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flight Schedule"),
        backgroundColor: Color.fromARGB(255, 35, 127, 202),
      ),
      drawer: MenuDrawer(),
      bottomNavigationBar: MyBottomNavBar(),
      body: ListView(
        children: getAlltheData(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddSportsActivity,
        child: Icon(Icons.add),
      ),
    );
  }

  List<Widget> getAlltheData() {
    List<Widget> listSportsEntriesWidgets = [];

    sportsEntries.forEach((element) {
      listSportsEntriesWidgets.add(Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          sharedPrefHelper
              .removeExistingEntry(element.id.toString())
              .then((value) {
            sportsEntries = sharedPrefHelper.getAllofSportsDate();
            setState(() {});
          });
        },
        child: ListTile(
          title: Text(element.description),
          subtitle: Text(element.date),
        ),
      ));
    });
    return listSportsEntriesWidgets;
  }

  Future onAddSportsActivity() async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter stateSetter) {
            return AlertDialog(
              title: const Text('Please Provide the Following Information'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: controllerDate,
                      onTap: _selectDateFunction,
                      readOnly: true,
                      decoration: const InputDecoration(
                          hintText: "Please Select the Date"),
                    ),
                    TextField(
                      controller: controllerDescription,
                      decoration: const InputDecoration(
                          hintText: "Please Provide info of the Flight"),
                    ),
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.redAccent),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      controllerDate.text = "";
                      controllerDescription.text = "";
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                    child: const Text("Cancel")),
                ElevatedButton(
                    onPressed: () {
                      String date = controllerDate.text;
                      String description = controllerDescription.text;

                      if (date != "" && description != "") {
                        int savedCounter =
                            sharedPrefHelper.getExisitingCounter();

                        SportEntry entry =
                            SportEntry(savedCounter, description, date);
                        sharedPrefHelper.writeSportsEntry(entry);
                        controllerDate.text = "";
                        controllerDescription.text = "";
                        Navigator.of(context).pop();
                        sportsEntries = sharedPrefHelper.getAllofSportsDate();
                        setState(() {});
                      } else {
                        errorMessage =
                            "Please Provide all the data in the fields";
                        stateSetter(
                          () {},
                        );
                      }
                    },
                    child: const Text("Save Entry"))
              ],
            );
          });
        });
  }

  Future _selectDateFunction() async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month + 2));

    if (selectedDate != null) {
      controllerDate.text =
          "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      setState(() {});
    } else {
      controllerDate.text = "Please Select Some Valid Date";
      setState(() {});
    }
  }
}
