import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id;
  double weight;
  double height;
  int age;

  User({
    this.id = 0,
    required this.weight,
    required this.height,
    required this.age,
  });

  // Calculate BMI
  double get bmi => weight / (height * height);


  double get bmr =>
      (88.362 + (13.397 * weight) + (4.799 * (height * 100)) - (5.677 * age)) *
          1.55;
}