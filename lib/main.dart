import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'boxes.dart';
import 'firebase_options.dart';
import 'models/interest.dart';
import 'models/usernotification.dart';
import 'screens/choose_interest.dart';
import 'screens/home.dart';
import 'screens/web_view_screen.dart';
import 'widgets/loading.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  // print("Handling a background message: ${message.data}");
  // final newsUrl = message.data['newsUrl'];
  // print(newsUrl);
  // Navigate to the news webview page.
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  await Hive.initFlutter();
  Hive.registerAdapter(UserInterestAdapter());
  Hive.registerAdapter(UserNotificationAdapter());
  await Hive.openBox<UserInterest>('userInterest');
  await Hive.openBox<UserNotification>('notification');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _loading = true;
  bool _openNotification = false;
  String? notificationNewsUrl;
  @override
  void initState() {
    super.initState();
    // SQ JP - Handeling notification message when app is terminated.
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      // Fluttertoast.showToast(
      //   msg: "Message: ${message}",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 2,
      //   backgroundColor: const Color(0xffF3FAE7),
      //   textColor: Colors.black,
      //   fontSize: 12.0,
      // );
      // Check if message is null
      if (message != null) {
        // Check if the message has data
        if (message.data.isNotEmpty) {
          // Check if the message has a newsUrl
          if (message.data.containsKey('newsUrl')) {
            String newsUrl = message.data['newsUrl'];
            setState(() {
              _openNotification = true;
              notificationNewsUrl = newsUrl;
            });
          }
        }
      }
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Closing the box when the app is closed.
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data.containsKey('newsUrl')) {
        String newsUrl = message.data['newsUrl'];
        print("party to banti hai");
        setState(() {
          _openNotification = true;
          notificationNewsUrl = newsUrl;
        });
      }
    });

    if (_openNotification) {
      // Sening news url and isNotification as true to the FullNews screen so that when the user press back button, the app will navigate to the home screen.
      return MaterialApp(
          title: 'Babushahi',
          home: FullNews(
            url: notificationNewsUrl!,
            isNotification: _openNotification,
          ));
    }

    return MaterialApp(
        title: 'Babushahi',
        // TODO: Make Theme Data

        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _loading
            ? homeLoadingWidget()
            // If the user has not selected any interest, show the choose interest screen, else show the home screen.
            : Boxes.getInterestBox().isEmpty ||
                    Boxes.getNotificationBox().isEmpty
                ? const ChooseInterest()
                : const HomePage());
  }
}
