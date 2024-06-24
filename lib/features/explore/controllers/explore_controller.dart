import 'package:coonch/utils/constants/image_strings.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController{

  List<String> categoriesNames = [
    "Mathematics",
    "Geography",
    "Physics",
    "Entertainment",
    "Science",
    "Fiction",
    "Non fiction"
  ];

  List<String> categoriesIcons = [
    MIcons.iconMathematics,
    MIcons.iconGeography,
    MIcons.iconPhysics,
    MIcons.iconEntertainment,
    MIcons.iconScience,
    MIcons.iconFiction,
    MIcons.iconNonFiction,
  ];
}