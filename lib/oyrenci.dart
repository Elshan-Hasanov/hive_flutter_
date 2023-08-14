import 'package:hive_flutter/hive_flutter.dart';
part 'oyrenci.g.dart';
@HiveType(typeId: 1)
class Oyrenci {
  @HiveField(0,defaultValue: 555)
   final int id;
     @HiveField(1)
    final String ad;
      @HiveField(2)
     final GozReng gozReng;

 Oyrenci (this.id, this.ad, this.gozReng);
 @override
  String toString() {

    return '$id - $ad - $gozReng';
  }
}
@HiveType(typeId: 2)
enum GozReng{  @HiveField(0,defaultValue: true)siyah,  @HiveField(1)mavi,  @HiveField(2)yasil}