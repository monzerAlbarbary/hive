import 'package:hive/hive.dart';

part 'model_bird.g.dart';



@HiveType(typeId: 0)
class Bird extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String family;

  @HiveField(2)
  final String order;

  Bird({required this.name, required this.family, required this.order});

  factory Bird.fromJson(Map<String, dynamic> json) {
    return Bird(
      name: json['name'],
      family: json['family'],
      order: json['order'],
    );
  }
}
