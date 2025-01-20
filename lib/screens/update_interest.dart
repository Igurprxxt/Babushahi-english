// To be shown to the user on first launch of the app, save the data in local hive DB.
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../boxes.dart';
import '../controllers/mobile_notification.dart';
import '../models/interest.dart';
import '../news_categories.dart' as newsCategories;

class UpdateInterest extends StatefulWidget {
  const UpdateInterest({super.key});

  @override
  State<UpdateInterest> createState() => _UpdateInterestState();
}

class _UpdateInterestState extends State<UpdateInterest> {
  // Making a list with all the items as false, the 'selectedStatus' list has the same length as the 'data' list.
  List<bool> selectedStatus =
      List.filled(newsCategories.newsChoices.length, false);
  List<String> selectedList = [];
  // list of selected interest, with full name
  List<String> selectedListFullName = [];
  bool allSelectedButtonState = false;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    // Scrolling the list to show the complete list
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 2000), curve: Curves.ease);
    });
    final List<UserInterest> selectedInterest =
        Boxes.getInterestBox().values.toList();
    for (int i = 0; i < selectedInterest.length; i++) {
      selectedList.add(selectedInterest[i].name);
      selectedListFullName.add(selectedInterest[i].displayName);
    }
    // Changed selected in UI to the data saved in the local Hive DB
    for (int i = 0; i < selectedList.length; i++) {
      for (int j = 0; j < newsCategories.newsChoices.length; j++) {
        if (selectedList[i] == newsCategories.newsChoices.values.toList()[j]) {
          selectedStatus[j] = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffF3FAE7),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Text(
                  'News Choices',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 5, width: MediaQuery.of(context).size.width),
                const Text(
                  'Update Interest',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select all ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (allSelectedButtonState) {
                      setState(() {
                        // Making all the items in the list as false (un selected)
                        selectedStatus = List.filled(
                            newsCategories.newsChoices.length, false);
                        selectedList = [];
                        selectedListFullName = [];
                        // making icon as selected checkbox
                        allSelectedButtonState = false;
                      });
                    } else {
                      setState(() {
                        // Making all the items in the list as true (selected)
                        selectedStatus = List.filled(
                            newsCategories.newsChoices.length, true);
                        // TODO: Add all the items to the list
                        selectedList = newsCategories.newsChoices.values
                            .toList()
                            .cast<String>();
                        selectedListFullName = newsCategories.newsChoices.keys
                            .toList()
                            .cast<String>();
                        // making icon as un selected checkbox
                        allSelectedButtonState = true;
                      });
                    }
                  },
                  icon: allSelectedButtonState
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: newsCategories.newsChoices.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedStatus[index]
                              ? const Color(0xff1CBD7A)
                              : const Color(0xffffffff),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: ListTile(
                        title: Text(
                          newsCategories.newsChoices.keys.toList()[index],
                          style: TextStyle(
                            color: selectedStatus[index]
                                ? Colors.white
                                : Colors.black,
                            // color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add_circle_outline_rounded,
                            color: selectedStatus[index]
                                ? Colors.white
                                : const Color(0xff1CBD7A),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedStatus[index] = !selectedStatus[index];
                              // Adding the selected item to the list
                              if (selectedStatus[index]) {
                                selectedList.add(
                                  newsCategories.newsChoices.values
                                      .toList()[index],
                                );
                                selectedListFullName.add(
                                  newsCategories.newsChoices.keys
                                      .toList()[index],
                                );
                              } else {
                                selectedList.remove(
                                  newsCategories.newsChoices.values
                                      .toList()[index],
                                );
                                selectedListFullName.remove(
                                  newsCategories.newsChoices.keys
                                      .toList()[index],
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
                // ),
              ),
            ),
            // Empty Container to push the button to the bottom
            Expanded(child: Container()),
            ElevatedButton(
              onPressed: () {
                // check if interest is selected
                if (selectedList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select at least one interest'),
                    ),
                  );
                  return;
                }
                // Remove all the previous interests saved in the Hive DB
                Boxes.getInterestBox().clear().then((value) {
                  for (int i = 0; i < selectedList.length; i++) {
                    UserInterest englishInterest = UserInterest()
                      ..displayName = selectedListFullName[i]
                      ..name = selectedList[i];
                    Boxes.addInterest(englishInterest);
                  }
                  // Making API call for Notification Setup
                  FirebaseMessaging.instance.getToken().then((token) {
                    MobileNotification.sendIdWithInterests(
                      // Sending Token and User Interests to the server
                      token: token!,
                      interests: selectedList,
                    );
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User Interest Updated'),
                    ),
                  );
                  // Sending 2 route back
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
              },
              style: ButtonStyle(
                minimumSize: const MaterialStatePropertyAll(Size(350, 65)),
                shape: const MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => const Color(0xff1A52C2)),
              ),
              child: const Text(
                'NEXT',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
