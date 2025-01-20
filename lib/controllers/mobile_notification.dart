import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../base_url.dart';
import 'package:dio/dio.dart';

class MobileNotification {
  static sendIdWithInterests(
      {required String token, required List<String> interests}) async {
    print("token" + token);
    // This method sends the firebase token and user interests (for notification) to the server.
    final dio = Dio();
    try {
      // print(interests);
      // print(
      //     'https://www.babushahi.com/appapi/addmobileid.php?secretkey=6kubnU4)53ez&mobid=$token&interest=$interests');
      // print("type of data: " + interests.runtimeType.toString());
      var data = {
        "secretkey": "6kubnU4)53ez",
        "interest": interests,
        "mobid": token
      };
      // https: //www.babushahi.com/appapi/addmobileid.php
      // Check platform is android or IOS
      var response;
      if (Platform.isAndroid) {
        response =
            await dio.post('${BaseUrl.apiUrl}/addmobileid.php', data: data);
      } else if (Platform.isIOS) {
        response =
            await dio.post('${BaseUrl.apiUrl}/addmobileidios.php', data: data);
      }

      // print(response);
      if (response.statusCode == 200) {
        print('Notification Setup Complete');
        // Show Toast Notification
        Fluttertoast.showToast(
          msg: "Notification Setup Complete",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xffF3FAE7),
          textColor: Colors.black,
          fontSize: 12.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Notification Setup Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color(0xffF3FAE7),
          textColor: Colors.black,
          fontSize: 12.0,
        );
        throw Exception('Error in Notification Setup, non 200 status code');
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "Notification Setup Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color(0xffF3FAE7),
        textColor: Colors.black,
        fontSize: 12.0,
      );
      throw Exception('Error in Notification Setup, failed to make API call');
    }
  }
}
