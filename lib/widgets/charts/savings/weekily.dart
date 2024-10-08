import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyChart extends StatefulWidget {
  const WeeklyChart({super.key});

  @override
  State<WeeklyChart> createState() => _WeeklyChartState();
}

class _WeeklyChartState extends State<WeeklyChart> {
  final List<FlSpot> leftData = [
    const FlSpot(0, 20000),
    const FlSpot(1, 30000),
    const FlSpot(2, 40000),
    const FlSpot(3, 50000),
    const FlSpot(4, 10000),
    const FlSpot(5, 23000),
    const FlSpot(6, 20000),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return const Text('Mon');
                      case 1:
                        return const Text('Tue');
                      case 2:
                        return const Text('Wed');
                      case 3:
                        return const Text('Thu');
                      case 4:
                        return const Text('Fri');
                      case 5:
                        return const Text('Sat');
                      case 6:
                        return const Text('Sun');
                      default:
                        return Container(width: 1);
                    }
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    return Text('${value.toInt()}');
                  },
                ),
              ),
              rightTitles: const AxisTitles(),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            minX: 0,
            maxX: 7,
            minY: 0,
            maxY: 70000,
            lineBarsData: [
              LineChartBarData(
                  spots: leftData,
                  isCurved: true,
                  color: Colors.green,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(show: true),
                  barWidth: 3),
            ],
          ),
        ));
  }
}
