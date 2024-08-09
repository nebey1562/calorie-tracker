import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'user.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class StatsScreen extends StatelessWidget {
  final User user;

  StatsScreen({Key? key, required this.user}) : super(key: key);

  final List<ChartData> _chartData = [
    ChartData("Sun", 2101.0),
    ChartData("Mon", 2312.0),
    ChartData("Tue", 2590.0),
    ChartData("Wed", 2217.0),
    ChartData("Thu", 2202.0),
    ChartData("Fri", 2300.0),
    ChartData("Sat", 2326.0),
  ];

  final List<Macro> _macro = [
    Macro("Carbs", 189, const Color.fromRGBO(255, 111, 97, 1)),
    Macro("Proteins", 142, const Color.fromRGBO(116, 120, 128, 1)),
    Macro("Fats", 63, const Color.fromRGBO(30, 86, 81, 1)),
  ];

  final List<Weighttracking> _weight = [
    Weighttracking("Week 1", 66.15),
    Weighttracking("Week 2", 64.7),
    Weighttracking("Week 3", 64.9),
    Weighttracking("Week 4", 64.0),
  ];

  @override
  Widget build(BuildContext context) {
    final double totalBmi = user.bmi;
    final String bmistring = '${totalBmi.toStringAsFixed(0)}';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '\nCalorie Details',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Calorie Intake Title
            Container(
              width: 450,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Calorie Intake",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Bar Chart
            Container(
              height: 250,
              width: 450,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(),
                palette: const <Color>[
                  Colors.indigoAccent,
                ],
                series: <CartesianSeries>[
                  BarSeries<ChartData, String>(
                    dataSource: _chartData,
                    isTrackVisible: true,
                    xValueMapper: (ChartData data, _) => data.day,
                    yValueMapper: (ChartData data, _) => data.cals,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Daily Macros Title
            Container(
              width: 450,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Daily Macros",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Macros Chart
            Container(
              height: 250,
              width: 450,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  // Column for text
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Diet Goal",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Carbs: 48%",
                          style: TextStyle(
                            color: Color.fromRGBO(255, 111, 97, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Protein: 36%",
                          style: TextStyle(
                            color: Color.fromRGBO(116, 120, 128, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Fats: 16%",
                          style: TextStyle(
                            color: Color.fromRGBO(30, 86, 81, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Donut chart on the right
                  Expanded(
                    flex: 2,
                    child: SfCircularChart(
                      series: <CircularSeries>[
                        DoughnutSeries<Macro, String>(
                          dataSource: _macro,
                          pointColorMapper: (Macro data, _) => data.color,
                          xValueMapper: (Macro data, _) => data.macros,
                          yValueMapper: (Macro data, _) => data.amount,
                          dataLabelSettings: const DataLabelSettings(isVisible: false),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // BMI Level Title
            Container(
              width: 450,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "BMI Level",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // BMI Gauge
            Container(
              width: 450,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(8.0),
              child: SfRadialGauge(
                title: GaugeTitle(
                  text: 'Your BMI',
                  textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 14,
                    maximum: 28,
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(widget: Container(child:
                      Text(bmistring,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
                          angle: 90,positionFactor: 0.5)],
                    ranges: <GaugeRange>[
                      GaugeRange(startValue: 14, endValue: 16, color: Colors.red, startWidth: 10, endWidth: 10),
                      GaugeRange(startValue: 16, endValue: 18, color: Colors.orange, startWidth: 10, endWidth: 10),
                      GaugeRange(startValue: 18, endValue: 24, color: Colors.green, startWidth: 10, endWidth: 10),
                      GaugeRange(startValue: 24, endValue: 26, color: Colors.orange, startWidth: 10, endWidth: 10),
                      GaugeRange(startValue: 26, endValue: 28, color: Colors.red, startWidth: 10, endWidth: 10),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(value: totalBmi),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Weight Tracking Title
            Container(
              width: 450,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Weight Tracking",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Weight Tracking Chart
            Container(
              height: 250,
              width: 450,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(),
                palette: const <Color>[
                  Colors.indigoAccent,
                ],
                series: <CartesianSeries>[
                  LineSeries<Weighttracking, String>(
                    dataSource: _weight,
                    xValueMapper: (Weighttracking data, _) => data.week,
                    yValueMapper: (Weighttracking data, _) => data.weight,
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.day, this.cals);
  final String day;
  final double cals;
}

class Macro {
  Macro(this.macros, this.amount, this.color);
  final String macros;
  final double amount;
  final Color color;
}

class Weighttracking {
  Weighttracking(this.week, this.weight);
  final String week;
  final double weight;
}
