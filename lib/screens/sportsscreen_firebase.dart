import 'package:flutter/material.dart';
import 'package:flutter_application_2/common/bottomnavbar.dart';
import 'package:flutter_application_2/common/menudrawer.dart';
//  import 'package:flutter_application_2/data/firbasehelper.dart';
import 'package:flutter_application_2/data/sports_entry.dart';
import 'package:flutter_application_2/data/sqlitehelper.dart';
import 'package:flutter_application_2/data/firebasehelper.dart';





class SportsScreenSQlite extends StatefulWidget {
  const SportsScreenSQlite({super.key});

  @override
  State<SportsScreenSQlite> createState() => _SportsScreenSQliteState();
}

class _SportsScreenSQliteState extends State<SportsScreenSQlite> {
  FirestoreHelper firestoreHepler = FirestoreHelper();
  SQliteHelper sQliteHelper = SQliteHelper();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<SportEntry> sportsEntries = [];
  List<SportEntry> filteredSportsEntries = [];
  int runningCounter = 1;
  String errorMessage = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sQliteHelper.init().then((value) {
      sQliteHelper.getAllofSportsDate().then((value) {
        sportsEntries = value;
        filteredSportsEntries = List.from(sportsEntries);
        setState(() {});
      });
    });

    searchController.addListener(onSearchTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FireBase Flight"),
        backgroundColor: Color.fromARGB(255, 35, 127, 202),
      ),
      drawer: MenuDrawer(),
      bottomNavigationBar: MyBottomNavBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                  hintText: "Search here!",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder()),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .8,
            child: ListView(
              children: getAlltheData(),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddSportsActivity,
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> getAlltheData() {
    List<Widget> listSportsEntriesWidgets = [];

    filteredSportsEntries.forEach((element) {
      listSportsEntriesWidgets.add(Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          sQliteHelper.removeExistingEntry(element.id.toString()).then((value) {
            sQliteHelper.getAllofSportsDate().then((value) {
              sportsEntries = value;
              filteredSportsEntries = List.from(sportsEntries);
              searchController.text = "";
              setState(() {});
            });
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
                      decoration: InputDecoration(
                          hintText: "Please Provide the info of the flight"),
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
                        sQliteHelper.getExisitingCounter().then((value) {
                          int savedCounter = value;
                          SportEntry entry =
                              SportEntry(savedCounter + 1, description, date);
                          sQliteHelper.writeSportsEntry(entry).then((value) {
                            controllerDate.text = "";
                            controllerDescription.text = "";
                            Navigator.of(context).pop();
                            sQliteHelper.getAllofSportsDate().then((value) {
                              sportsEntries = value;
                              filteredSportsEntries = List.from(sportsEntries);
                              searchController.text = "";
                              setState(() {});
                            });
                          });
                        });
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

  void onSearchTextChanged() {
    filteredSportsEntries = sportsEntries
        .where((element) => element.description
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();

    setState(() {});
  }
}
