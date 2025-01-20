// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usernotification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserNotificationAdapter extends TypeAdapter<UserNotification> {
  @override
  final int typeId = 1;

  @override
  UserNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserNotification()..is_notification_allowed = fields[0] as bool;
  }

  @override
  void write(BinaryWriter writer, UserNotification obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.is_notification_allowed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
