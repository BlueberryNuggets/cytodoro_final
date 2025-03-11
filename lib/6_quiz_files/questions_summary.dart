import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: summaryData.map(
              (data) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xfffac23d),
                            ),
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            child: Text(
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff432907),
                                ),
                                textAlign: TextAlign.center,
                                ((data['question_index'] as int) + 1)
                                    .toString())),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xfffbfbf1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(data['question'] as String, textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.w500),),
                                SizedBox(height: 8),
                                Text("📝 ${data['user_answer'] as String}"),
                                Text("🟩 ${data['correct_answer'] as String}"),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
