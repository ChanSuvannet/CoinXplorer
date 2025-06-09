import 'package:coinxplorer/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ), // 8px padding on x-axis

      child: Flex(
        direction: Axis.horizontal,
        children: [
          const SizedBox(height: AppStyles.spacing * 6),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 80,
              ), // Increased to prevent overflow
              child: Container(
                padding: const EdgeInsets.all(4), // 4px padding
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4), // Smaller radius
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2, // Reduced blur
                      offset: Offset(0, 1), // Reduced offset
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Market Cap',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 2), // Reduced spacing
                    Text(
                      '\$1.56T',
                      style: const TextStyle(
                        fontSize: 18, // Reduced font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_drop_up,
                          size: 25,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '5.78%',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 80,
              ), // Increased to prevent overflow
              child: Container(
                padding: const EdgeInsets.all(4), // 4px padding
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4), // Smaller radius
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2, // Reduced blur
                      offset: Offset(0, 1), // Reduced offset
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Volume',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 2), // Reduced spacing
                    Text(
                      '\$1.12T',
                      style: const TextStyle(
                        fontSize: 18, // Reduced font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 25,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '3.44%',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 80,
              ), // Increased to prevent overflow
              child: Container(
                padding: const EdgeInsets.all(4), // 4px padding
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4), // Smaller radius
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2, // Reduced blur
                      offset: Offset(0, 1), // Reduced offset
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dominance',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 2), // Reduced spacing
                    Text(
                      '50.46%',
                      style: const TextStyle(
                        fontSize: 18, // Reduced font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.btc,
                            size: 14,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 2),
                          const Text(
                            'BTC',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 80,
              ), // Increased to prevent overflow
              child: Container(
                padding: const EdgeInsets.all(4), // 4px padding
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4), // Smaller radius
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2, // Reduced blur
                      offset: Offset(0, 1), // Reduced offset
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fear & Greed',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 2), // Reduced spacing
                    SizedBox(
                      height: 50, // Kept compact but fits within 80px
                      child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                            minimum: 0,
                            maximum: 100,
                            showLabels: false,
                            showTicks: false,
                            axisLineStyle: AxisLineStyle(
                              thickness: 0.15, // Reduced thickness
                              thicknessUnit: GaugeSizeUnit.factor,
                              cornerStyle: CornerStyle.bothFlat,
                              gradient: const SweepGradient(
                                colors: [
                                  Colors.red,
                                  Colors.orange,
                                  Colors.yellow,
                                  Colors.green,
                                ],
                                stops: [0.25, 0.5, 0.75, 1.0],
                              ),
                            ),
                            pointers: const [NeedlePointer(value: 50)],
                            annotations: [
                              GaugeAnnotation(
                                widget: const Text(
                                  '50',
                                  style: TextStyle(
                                    fontSize: 12, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                angle: 90,
                                positionFactor: 0.5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
