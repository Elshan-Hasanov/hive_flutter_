// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oyrenci.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OyrenciAdapter extends TypeAdapter<Oyrenci> {
  @override
  final int typeId = 1;

  @override
  Oyrenci read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Oyrenci(
      fields[0] == null ? 555 : fields[0] as int,
      fields[1] as String,
      fields[2] as GozReng,
    );
  }

  @override
  void write(BinaryWriter writer, Oyrenci obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.ad)
      ..writeByte(2)
      ..write(obj.gozReng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OyrenciAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GozRengAdapter extends TypeAdapter<GozReng> {
  @override
  final int typeId = 2;

  @override
  GozReng read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GozReng.siyah;
      case 1:
        return GozReng.mavi;
      case 2:
        return GozReng.yasil;
      default:
        return GozReng.siyah;
    }
  }

  @override
  void write(BinaryWriter writer, GozReng obj) {
    switch (obj) {
      case GozReng.siyah:
        writer.writeByte(0);
        break;
      case GozReng.mavi:
        writer.writeByte(1);
        break;
      case GozReng.yasil:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GozRengAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
