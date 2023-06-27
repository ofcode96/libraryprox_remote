import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/widgets/loader.dart';
import 'package:libraryprox_remote/features/dashboard/services/borrows_services.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({
    super.key,
  });

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  BorrowsServices borrowsServices = BorrowsServices();
  List<int> days = [];
  final List<FlSpot> _spots = [];
  String year = '';
  String month = '';

  generateCurrentMounth() {}

  statistics() async {
    var data = await borrowsServices.borrowStatistics(context);
    var notValid = jsonDecode(data.body) as Map<String, dynamic>;

    return notValid;
  }

  generateData(Map<String, dynamic> notValid) {
    DateTime now = DateTime.now();

    notValid.forEach((key, value) {
      String currentYear = now.year.toString();
      year = currentYear;
      if (key == currentYear) {
        var currentYearData = value as Map<String, dynamic>;
        currentYearData.forEach((key, value) {
          String currentMonth = now.month.toString();
          whichMonth();
          if (key == currentMonth) {
            var spots = value as Map<String, dynamic>;
            spots.forEach((key, value) {
              _spots.add(FlSpot(double.parse(key), double.parse("$value")));
            });
          }
        });
      }
    });
  }

  whichMonth() {
    switch (DateTime.now().month) {
      case DateTime.january:
        month = "january".toUpperCase();
        break;
      case DateTime.february:
        month = "february".toUpperCase();
        break;
      case DateTime.march:
        month = "march".toUpperCase();
        break;
      case DateTime.april:
        month = "april".toUpperCase();
        break;
      case DateTime.may:
        month = "may".toUpperCase();
        break;
      case DateTime.june:
        month = "June".toUpperCase();
        break;
      case DateTime.july:
        month = "july".toUpperCase();
        break;
      case DateTime.august:
        month = "august".toUpperCase();
        break;
      case DateTime.september:
        month = "september".toUpperCase();
        break;
      case DateTime.november:
        month = "november".toUpperCase();
        break;
      case DateTime.december:
        month = "december".toUpperCase();
        break;

      default:
        month = DateTime.now().month.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    generateCurrentMounth();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
        // color: Colors.pink,
        height: MediaQuery.of(context).size.height * .35,
        child: FutureBuilder(
            future: statistics(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Some Error"),
                );
              }
              if (snapshot.hasData) {
                generateData(snapshot.data as Map<String, dynamic>);
                return Column(
                  children: [
                    Text("$month $year"),
                    Expanded(
                      child: LineChart(
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeIn,
                        LineChartData(
                          minX: 1,
                          minY: 0,
                          maxX: 31,
                          maxY: 40,
                          gridData: const FlGridData(
                            show: false,
                            drawHorizontalLine: true,
                            drawVerticalLine: false,
                          ),
                          titlesData: const FlTitlesData(
                            bottomTitles: AxisTitles(
                                axisNameSize: 1,
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 25,
                                  interval: 8,
                                )),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                                isStrokeCapRound: false,
                                curveSmoothness: .30,
                                isCurved: true,
                                barWidth: 4,
                                isStrokeJoinRound: true,
                                dotData: const FlDotData(show: false),
                                belowBarData: BarAreaData(
                                    show: true,
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(136, 66, 226, 215),
                                          Color.fromRGBO(159, 234, 241, 0.179)
                                        ])),
                                spots: _spots
                                // spots: [
                                //   const FlSpot(0, 10),
                                //   const FlSpot(1, 15),
                                //   const FlSpot(5, 30),
                                //   const FlSpot(7, 25),
                                //   const FlSpot(8, 22),
                                //   const FlSpot(9, 28),
                                //   const FlSpot(12, 4),
                                //   const FlSpot(14, 30),
                                //   const FlSpot(15, 25),
                                //   const FlSpot(24, 30),
                                //   const FlSpot(28, 25),
                                //   const FlSpot(30, 15),
                                //   const FlSpot(31, 40),
                                // ],
                                ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text("Some Error"),
                );
              }
            }),
      ),
    );
  }
}
