import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connections/3_piechart_files/pie_chart_state_provider.dart';

class MyPieChart extends StatefulWidget {
  final Function(int) onSegmentClicked;

  const MyPieChart({super.key, required this.onSegmentClicked});

  @override
  State<MyPieChart> createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    int currentStage = Provider.of<PieChartState>(context).scalingStage;

    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            if (!event.isInterestedForInteractions ||
                pieTouchResponse == null ||
                pieTouchResponse.touchedSection == null) {
              return;
            }
            int segmentIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;

            if (segmentIndex == currentStage) {
              widget.onSegmentClicked(segmentIndex + 1);
            }
          },
        ),
        sections: [
          PieChartSectionData(
            value: 41,
            color: currentStage >= 0 ? Color(0xffc660e7) : Color(0xffc660e7).withOpacity(0.3),
            radius: touchedIndex == 0 ? 160 : 150,
            title: "G1",
            titleStyle: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          PieChartSectionData(
            value: 25,
            color: currentStage >= 1 ? Color(0xfffe9004) : Color(0xfffe9004).withOpacity(0.3),
            radius: touchedIndex == 1 ? 160 : 150,
            title: "S",
            titleStyle: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          PieChartSectionData(
            value: 21,
            color: currentStage >= 2 ? Color(0xffffde59) : Color(0xffffde59).withOpacity(0.3),
            radius: touchedIndex == 2 ? 160 : 150,
            title: "G2",
            titleStyle: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          PieChartSectionData(
            value: 13,
            color: currentStage >= 3 ? Color(0xff9bdb00) : Color(0xff9bdb00).withOpacity(0.3),
            radius: touchedIndex == 3 ? 160 : 150,
            title: "M",
            titleStyle: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}


// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:connections/3_piechart_files/pie_chart_state_provider.dart';

// class MyPieChart extends StatefulWidget {
//   final Function(int) onSegmentClicked;

//   const MyPieChart({super.key, required this.onSegmentClicked});

//   @override
//   State<MyPieChart> createState() => _MyPieChartState();
// }

// class _MyPieChartState extends State<MyPieChart> {
//   int touchedIndex = -1;
//   int activeSegment = 0;

//   Map<int, bool> getClickedFlags(BuildContext context) {
//     return Provider.of<PieChartState>(context, listen: false).clickedFlags;
//   }

//   void setClickedFlag(BuildContext context, int index, bool value) {
//     Provider.of<PieChartState>(context, listen: false).setClickedFlag(index, value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PieChart(
//       PieChartData(
//         pieTouchData: PieTouchData(
//           touchCallback: (FlTouchEvent event, pieTouchResponse) {
//             setState(() {
//               if (!event.isInterestedForInteractions ||
//                   pieTouchResponse == null ||
//                   pieTouchResponse.touchedSection == null) {
//                 touchedIndex = -1;
//                 return;
//               }
//               touchedIndex =
//                   pieTouchResponse.touchedSection!.touchedSectionIndex;

//               switch (touchedIndex) {
//                 case 0:
//                   _onG1Click(context);
//                   break;
//                 case 1:
//                   _onSClick(context);
//                   break;
//                 case 2:
//                   _onG2Click(context);
//                   break;
//                 case 3:
//                   _onMClick(context);
//                   break;
//                 default:
//                   break;
//               }
//             });
//           },
//         ),
//         sections: [
//           PieChartSectionData(
//             value: 41,
//             color: activeSegment >= 0
//                 ? Colors.blueAccent
//                 : Colors.blueAccent.withOpacity(0.3),
//             radius: touchedIndex == 0 ? 160 : 150,
//             title: "G1",
//             titleStyle: const TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold),
//           ),
//           PieChartSectionData(
//             value: 25,
//             color: activeSegment >= 1
//                 ? Colors.greenAccent
//                 : Colors.greenAccent.withOpacity(0.3),
//             radius: touchedIndex == 1 ? 160 : 150,
//             title: "S",
//             titleStyle: const TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold),
//           ),
//           PieChartSectionData(
//             value: 21,
//             color: activeSegment >= 2
//                 ? Colors.yellowAccent
//                 : Colors.yellowAccent.withOpacity(0.3),
//             radius: touchedIndex == 2 ? 160 : 150,
//             title: "G2",
//             titleStyle: const TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold),
//           ),
//           PieChartSectionData(
//             value: 13,
//             color: activeSegment >= 3
//                 ? Colors.orangeAccent
//                 : Colors.orangeAccent.withOpacity(0.3),
//             radius: touchedIndex == 3 ? 160 : 150,
//             title: "M",
//             titleStyle: const TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }

//   void _onG1Click(BuildContext context) {
//     if (!getClickedFlags(context)[0]!) {
//       setState(() {
//         activeSegment = 1;
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('G1 segment clicked!')),
//         );
//         widget.onSegmentClicked(1);
//         setClickedFlag(context, 0, true);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Proceed to the next stage.')),
//       );
//     }
//   }

//   void _onSClick(BuildContext context) {
//     if (!getClickedFlags(context)[1]!) {
//       setState(() {
//         activeSegment = 2;
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('S segment clicked!')),
//         );
//         widget.onSegmentClicked(2);
//         setClickedFlag(context, 1, true);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Proceed to the next stage.')),
//       );
//     }
//   }

//   void _onG2Click(BuildContext context) {
//     if (!getClickedFlags(context)[2]!) {
//       setState(() {
//         activeSegment = 3;
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('G2 segment clicked!')),
//         );
//         widget.onSegmentClicked(3);
//         setClickedFlag(context, 2, true);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Proceed to the next stage.'),),
//       );
//     }
//   }

//   void _onMClick(BuildContext context) {
//     if (!getClickedFlags(context)[3]!) {
//       setState(() {
//         activeSegment = 4;
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('M segment clicked!')),
//         );
//         widget.onSegmentClicked(4);
//         setClickedFlag(context, 3, true);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Your cell has successfully undergone a full life cycle!.')),
//       );
//     }
//   }
// }