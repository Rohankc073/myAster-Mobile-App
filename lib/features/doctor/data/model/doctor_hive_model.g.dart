// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorHiveModelAdapter extends TypeAdapter<DoctorHiveModel> {
  @override
  final int typeId = 1;

  @override
  DoctorHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorHiveModel(
      id: fields[0] as String?,
      name: fields[1] as String,
      contact: fields[2] as String?,
      email: fields[3] as String?,
      image: fields[4] as String,
      specialization: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.contact)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.specialization);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
