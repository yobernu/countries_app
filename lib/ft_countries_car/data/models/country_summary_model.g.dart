// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_summary_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountrySummaryModelAdapter extends TypeAdapter<CountrySummaryModel> {
  @override
  final int typeId = 0;

  @override
  CountrySummaryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++)
        reader.readByte(): reader.read(),
    };
    return CountrySummaryModel(
      name: fields[0] as String,
      flag: fields[1] as String,
      population: fields[2] as int,
      cca2: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CountrySummaryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.flag)
      ..writeByte(2)
      ..write(obj.population)
      ..writeByte(3)
      ..write(obj.cca2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountrySummaryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
