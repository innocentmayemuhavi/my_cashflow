import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyChart extends StatefulWidget {
  const MonthlyChart({super.key});

  @override
  State<MonthlyChart> createState() => _MonthlyChartState();
}

class _MonthlyChartState extends State<MonthlyChart> {
  final List<FlSpot> leftData = [
    const FlSpot(0, 20000),
    const FlSpot(1, 30000),
    const FlSpot(2, 40000),
    const FlSpot(3, 50000),
    const FlSpot(4, 10000),
    const FlSpot(5, 23000),
    const FlSpot(6, 20000),
  ];

  final List<FlSpot> rightData = [
    const FlSpot(0, 10000),
    const FlSpot(1, 3000),
    const FlSpot(2, 40000),
    const FlSpot(3, 20000),
    const FlSpot(4, 40000),
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
                        return const Text('jan');
                      case 1:
                        return const Text('Feb');
                      case 2:
                        return const Text('Mar');
                      case 3:
                        return const Text('Apr');
                      case 4:
                        return const Text('May');
                      case 5:
                        return const Text('Jun');
                      case 6:
                        return const Text('Jul');
                      case 7:
                        return const Text('Aug');
                      case 8:
                        return const Text('Sep');
                      case 9:
                        return const Text('Oct');
                      case 10:
                        return const Text('Nov');
                      case 11:
                        return const Text('Dec');
                      default:
                        return Container(
                          width: 1,
                        );
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
            maxX: 12,
            minY: 0,
            maxY: 70000,
            lineBarsData: [
              LineChartBarData(
                  spots: leftData,
                  isCurved: true,
                  color: Colors.blue,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(show: true),
                  barWidth: 3),
              LineChartBarData(
                spots: rightData,
                isCurved: true,
                color: Colors.red,
                dotData: const FlDotData(show: true),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ));
  }
}
