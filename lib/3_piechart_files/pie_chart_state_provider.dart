import 'package:flutter/material.dart';

class PieChartState with ChangeNotifier {
  int scalingStage = 0;
  int selectedSegment = -1;

  void updateScalingStage(int stage) {
    scalingStage = stage;
    print("Updated scaling stage: $scalingStage");
    notifyListeners();
  }

  void updateSelectedSegment(int segment) {
    selectedSegment = segment;
    print("Updated selected segment: $selectedSegment");
    notifyListeners();
  }

  void reset() {
    scalingStage = 0;
    notifyListeners();
  }
}

// import 'package:flutter/material.dart';


// class PieChartState with ChangeNotifier {
//   int scalingStage = 0;
//   int selectedSegment = -1;

//   void updateScalingStage(int stage) {
//     scalingStage = stage;
//     print("Updated scaling stage: $scalingStage");
//     notifyListeners();
//   }

//   void updateSelectedSegment(int segment) {
//     selectedSegment = segment;
//     print("Updated selected segment: $selectedSegment");
//     notifyListeners();
//   }
// }
