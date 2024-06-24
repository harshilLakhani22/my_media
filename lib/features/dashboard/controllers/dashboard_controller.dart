import 'package:coonch/features/explore/screen/explore_screen.dart';
import 'package:coonch/features/home/screen/home_screen.dart';
import 'package:coonch/features/profile/screen/profile_screen.dart';
import 'package:coonch/features/search/controllers/search_screen_controller.dart';
import 'package:coonch/features/search/screen/search_screen.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isMenuOpen = false.obs;

  void changeTabIndex(int index) {
    currentIndex.value = index;
    if(currentIndex.value != 1){
      Get.find<SearchScreenController>().cleanSearchResult();
    }
  }

  void toggleMenu() {
    isMenuOpen.value = !isMenuOpen.value;
  }



  final screens = [
    HomeScreen(),
    SearchScreen(),
    ExploreScreen(),
    ProfileScreen(),
  ];
}
