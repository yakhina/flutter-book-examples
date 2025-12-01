// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_point_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestPointModelAdapter extends TypeAdapter<QuestPointModel> {
  @override
  final int typeId = 1;

  @override
  QuestPointModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestPointModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      latitude: fields[3] as double,
      longitude: fields[4] as double,
      radius: fields[5] as double,
      isCompleted: fields[6] as bool,
      cityId: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuestPointModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.radius)
      ..writeByte(6)
      ..write(obj.isCompleted)
      ..writeByte(7)
      ..write(obj.cityId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestPointModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
