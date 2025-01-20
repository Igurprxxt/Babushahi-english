import 'package:hive/hive.dart';
part 'usernotification.g.dart';

@HiveType(typeId: 1)
class UserNotification extends HiveObject {
  @HiveField(0)
  late bool is_notification_allowed;
}
