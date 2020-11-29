import 'package:calculatebmitest/model/humain.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BmiController extends GetxController {
  Humain humain = new Humain();
  @override
  void onInit() {
    GetStorage box = GetStorage();
    if (box.read("height").toString() != null) {
      humain.height = box.read("height");
      humain.age = box.read("Age");
      humain.weight = box.read("Weight");
      humain.genre = box.read("genre");
      humain.name = box.read("name");
    }
  }

  double get bmi => (humain.weight / (humain.height * humain.height)) * 10000;
  bmiResult() {
    double bmi = this.bmi;
    if (bmi < 18.5) {
      return "UNDERWEIGHT";
    } else if (bmi >= 18.5 && bmi < 25) {
      return "NORMAL";
    } else if (bmi > 25 && bmi <= 29.99) {
      return "OVERWEIGHT";
    } else {
      return "OBESE";
    }
  }
}
