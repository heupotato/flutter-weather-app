// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceAdapter extends TypeAdapter<Place> {
  @override
  final int typeId = 0;

  @override
  Place read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Place(
      id: fields[0] as String,
      type: fields[1] as String,
      placeType: (fields[2] as List).cast<String>(),
      text: fields[3] as String,
      placeName: fields[4] as String,
      geometry: fields[5] as Geometry,
      timeOffset: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Place obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.placeType)
      ..writeByte(3)
      ..write(obj.text)
      ..writeByte(4)
      ..write(obj.placeName)
      ..writeByte(5)
      ..write(obj.geometry)
      ..writeByte(6)
      ..write(obj.timeOffset);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
