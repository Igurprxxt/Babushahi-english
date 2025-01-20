import 'package:hive/hive.dart';
import 'models/interest.dart';
import 'models/usernotification.dart';

class Boxes {
  // UserInterest Methods below
  static Box<UserInterest> getInterestBox() =>
      Hive.box<UserInterest>('userInterest');

  static void addInterest(UserInterest interestEnglish) =>
      getInterestBox().add(interestEnglish);

  static void deleteAllInterest() {
    final List<UserInterest> selectedInterest =
        Boxes.getInterestBox().values.toList();
    for (int i = 0; i < selectedInterest.length; i++) {
      // print("deleting" + selectedInterest[i].displayName);
      getInterestBox().delete(selectedInterest[i]);
    }
  }

  // Notification Methods below
  static void defaultNotificationSetup() {
    // Setting up default notification as true
    UserNotification notification = UserNotification()
      ..is_notification_allowed = true;
    getNotificationBox().add(notification);
  }

  static Box<UserNotification> getNotificationBox() =>
      Hive.box<UserNotification>('notification');

  static bool getNotificationStatus() {
    Box<UserNotification> box = Boxes.getNotificationBox();
    // print('Notification Status' + box.toString());
    // print('Notification Status' + box.getAt(0).toString());
    UserNotification notification = box.getAt(0)!;
    return notification.is_notification_allowed;
  }

  // update notification
  static void updateNotificationStatus(bool status) {
    Box<UserNotification> box = Boxes.getNotificationBox();
    UserNotification notification = box.getAt(0)!;
    // print("first notif box");
    // print(notification.is_notification_allowed);
    notification.is_notification_allowed = status;
    box.putAt(0, notification);
  }
}
