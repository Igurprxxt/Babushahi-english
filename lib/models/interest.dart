import 'package:hive/hive.dart';

part 'interest.g.dart';

@HiveType(typeId: 0)
class UserInterest extends HiveObject {
  @HiveField(0)
  late String displayName;
  @HiveField(1)
  late String name;
}
