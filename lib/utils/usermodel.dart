import 'package:hive_flutter/hive_flutter.dart';
// part 'user_model.g.dart'; 

@HiveType(typeId: 0)
class UserModel extends HiveObject{
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? rollno;
  @HiveField(3)
  final String? currentMess;
  @HiveField(4)
  final String? nextMess;
  @HiveField(5)
  final int? messbalance;

  UserModel({this.name, this.email, this.rollno, this.currentMess, this.nextMess, this.messbalance});
}