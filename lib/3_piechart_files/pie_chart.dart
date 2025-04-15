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
            radius: touchedIndex == 0 ? 140 : 130,
            title: "G1",
            titleStyle: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          PieChartSectionData(
            value: 25,
            color: currentStage >= 1 ? Color(0xfffe9004) : Color(0xfffe9004).withOpacity(0.3),
            radius: touchedIndex == 1 ? 140 : 130,
            title: "S",
            titleStyle: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          PieChartSectionData(
            value: 21,
            color: currentStage >= 2 ? Color(0xffffde59) : Color(0xffffde59).withOpacity(0.3),
            radius: touchedIndex == 2 ? 140 : 130,
            title: "G2",
            titleStyle: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          PieChartSectionData(
            value: 13,
            color: currentStage >= 3 ? Color(0xff9bdb00) : Color(0xff9bdb00).withOpacity(0.3),
            radius: touchedIndex == 3 ? 140 : 130,
            title: "M",
            titleStyle: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
