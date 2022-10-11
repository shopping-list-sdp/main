import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_list/reusable_widgets/list_view_widgets.dart';
import 'package:shopping_list/global.dart' as global;
import '../custom_icons_icons.dart';
import '../model/pantryItem.dart';
import '../queries/pantry_queries.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/color_utils.dart';

class PantryCatagoryScreen extends StatefulWidget {
  final String catagory;
  const PantryCatagoryScreen({super.key, required this.catagory});

  @override
  State<PantryCatagoryScreen> createState() =>
      _PantryCatagoryScreenState(catagory);
}

class _PantryCatagoryScreenState extends State<PantryCatagoryScreen> {
  final searchTextEditingController = TextEditingController();
  final addTextEditingController = TextEditingController();

  var duplicateItems = global.items;
  var items = [];

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(global.items);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        //items.addAll(global.items);
      });
    }
  }

  String catagory;
  _PantryCatagoryScreenState(this.catagory);

  @override
  Widget build(BuildContext context) {
    global.pantryCategory = catagory;
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
            backgroundColor: myColors("White"),
            body: ListView(children: <Widget>[
              SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(
                    35, MediaQuery.of(context).size.height * 0.05, 35, 0),
                child: Column(children: <Widget>[
                  Text("Pantry",
                      style: TextStyle(
                          color: myColors("Purple"),
                          fontSize: 30,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Image(image: AssetImage('assets/images/stall.png')),
                      Text(catagory,
                          style: TextStyle(
                              color: myColors("White"),
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 330,
                        child: //searchField("Add items", CustomIcons.search,
                            //addTextEditingController, "Blue"),
                            TextField(
                                controller: addTextEditingController,
                                onChanged: (value) {
                                  filterSearchResults(value);
                                  if (addTextEditingController.toString() ==
                                      '') {
                                    items = [];
                                  }
                                },
                                textInputAction: TextInputAction.done,
                                cursorColor: myColors("Purple"),
                                style: TextStyle(
                                    color: myColors("Purple"),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    CustomIcons.search,
                                    color: myColors("Purple"),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        items = [];
                                        addTextEditingController.text = '';
                                      });
                                    },
                                    icon: Icon(
                                      Icons.cancel_rounded,
                                      color: myColors("FiftyGrey"),
                                    ),
                                  ),
                                  labelText: "Add Items",
                                  labelStyle: TextStyle(
                                      color: myColors("FiftyPurple"),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                  filled: true,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  fillColor: myColors("TwentyGrey"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(20),
                                          topRight: const Radius.circular(20),
                                          bottomLeft:
                                              addTextEditingController.text ==
                                                      ''
                                                  ? const Radius.circular(20)
                                                  : const Radius.circular(0),
                                          bottomRight:
                                              addTextEditingController.text ==
                                                      ''
                                                  ? const Radius.circular(20)
                                                  : const Radius.circular(0)),
                                      borderSide: const BorderSide(
                                          width: 0, style: BorderStyle.none)),
                                )),
                      ),
                    ],
                  ),
                  Container(
                      width: 325,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: myColors("TwentyGrey")),
                      //border: Border.all(color: Colors.blueAccent)),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length < 5 ? items.length : 5,
                        itemBuilder: (context, index) {
                          return ListTile(
                            //tileColor: myColors("TwentyGrey"),
                            /*shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            */
                            leading: Transform.translate(
                                offset: const Offset(-5, 0),
                                child: Icon(
                                  Icons.add,
                                  color: myColors("Purple"),
                                )),
                            title: Transform.translate(
                                offset: const Offset(-22, 0),
                                child: Text(
                                  items[index],
                                  style: TextStyle(color: myColors("Grey")),
                                )),
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              addTextEditingController.text = '';
                              String item = items[index];
                              setState(() {
                                items = [];
                              });
                              await addPantryItem(
                                  itemName: item, pantryID: global.myPantryId);
                              Fluttertoast.showToast(msg: "Item Added");
                            },
                          );
                        },
                      )),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          child: Text(
                            "Clear List     ",
                            style: TextStyle(
                                color: myColors("Purple"),
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          onPressed: () async {
                            await clearList();
                          })),
                  Column(
                    key: UniqueKey(),
                    children: [
                      for (var category in global.categories)
                        global.myList
                                .where(
                                    (element) => element.category == category)
                                .isEmpty
                            ? Column()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 25),
                                        Text(
                                            category[0].toUpperCase() +
                                                category.substring(
                                                    1), //make first letter capital
                                            style: TextStyle(
                                                color: myColors("Purple"),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    for (pantryItem entry in global.myPantry)
                                      if (entry.category ==
                                          global.pantryCategory)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 15),
                                            /*Checkbox(
                                                checkColor: Colors.white,
                                                fillColor: MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                  return myColors("Purple");
                                                }),
                                                value: !entry.toBuy,
                                                shape: const CircleBorder(),
                                                onChanged: (bool? val) {
                                                  changeToBuy(
                                                      !entry.toBuy, entry.id);
                                                  setState(() {
                                                    entry.toBuy = !val!;
                                                  });
                                                })*/
                                            Text(
                                                entry.itemId[0].toUpperCase() +
                                                    entry.itemId.substring(
                                                        1), //make first etter capital
                                                style: TextStyle(
                                                    color: myColors("Grey"),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal))
                                          ],
                                        ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ])
                    ],
                  ),
                ]),
              )),
            ]),
            appBar: appBar(context),
            bottomNavigationBar: navBar(context, "pantryCatagory")));
  }
}
