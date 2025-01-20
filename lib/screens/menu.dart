import 'package:babushahienglish/screens/home.dart';
import 'package:babushahienglish/screens/privacy_policy.dart';
import 'package:babushahienglish/screens/terms_page.dart';
import 'package:flutter/material.dart';
import '../models/interest.dart';
import '../boxes.dart';
import 'update_interest.dart';
import '../news_categories.dart' as newsCategories;

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    bool is_notification_on = Boxes.getNotificationStatus();
    bool allSelectedButtonState = false; // not used anywhere
    // list of selected interest
    final List<UserInterest> selectedInterest =
        Boxes.getInterestBox().values.toList();

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pause Notifications?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Do you want to pause notifications?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('PAUSE NOTIFICATIONS'),
                onPressed: () {
                  Boxes.updateNotificationStatus(false);
                  setState(() {
                    is_notification_on = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: const Color(0xffF3FAE7),
          leading: const BackButton(
            color: Colors.black,
          ),
        ),
        body: Container(
          width: double.infinity,
          color: const Color(0xffF3FAE7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                width: double.infinity,
                child: const Text(
                  'Menu Options',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                // Adding border color to the container
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black38),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Notifications Allowed',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Switch(
                      value: is_notification_on,
                      onChanged: (value) {
                        if (value == true) {
                          Boxes.updateNotificationStatus(value);
                          setState(() {
                            is_notification_on = true;
                          });
                        } else {
                          _showMyDialog();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xff1CBD7A)),
                  minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width * 0.9, 50)),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const UpdateInterest()));
                },
                child: const Text('Update News Interest'),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 10),
                  itemCount: selectedInterest.length,
                  itemBuilder: (context, index) => ListTile(
                    title: GestureDetector(
                      onTap: () {
                        final newsChoices = newsCategories.newsChoices;
                        // find selectedInterest[index] from newsChoices
                        int newIndex = newsChoices.values.toList().indexOf(
                            selectedInterest[index].name.toLowerCase());
                        print("index is : " + newIndex.toString());
                        // Sending index to the last page
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => HomePage(
                                      newTabIndex: newIndex + 1,
                                    )),
                            (Route<dynamic> route) => false);
                      },
                      child: Text(
                        selectedInterest[index].displayName,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Color(0xff1CBD7A),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const PrivacyPolicy()),
                          );
                        },
                        child: const Text(
                          'Privacy Policy',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      const Text(
                        '|',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      // TODO: add disclaimer page
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const TermsAndConditions()),
                          );
                        },
                        child: const Text(
                          'Terms and Conditions',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
