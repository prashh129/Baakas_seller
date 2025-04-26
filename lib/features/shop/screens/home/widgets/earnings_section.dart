import 'package:baakas_seller/features/shop/controllers/earnings_controller.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class EarningsSection extends StatelessWidget {
  const EarningsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EarningsController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Weekly Earnings Graph
        Card(
          child: Padding(
            padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weekly Earnings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: BaakasSizes.spaceBtwItems),
                Obx(() {
                  final weeklyData = controller.weeklyEarnings;
                  final hasData = weeklyData.any((day) => (day['amount'] as double) > 0);
                  
                  return SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        BarChart(
                          BarChartData(
                            gridData: const FlGridData(show: false),
                            titlesData: FlTitlesData(
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    if (value >= 0 && value < weeklyData.length) {
                                      final date = weeklyData[value.toInt()]['date'] as DateTime;
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          '${date.month}/${date.day}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }
                                    return const Text('');
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: weeklyData.asMap().entries.map((entry) {
                              return BarChartGroupData(
                                x: entry.key,
                                barRods: [
                                  BarChartRodData(
                                    toY: entry.value['amount'] as double,
                                    color: BaakasColors.primaryColor,
                                    width: 20,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                            alignment: BarChartAlignment.spaceAround,
                            maxY: hasData ? weeklyData.map((e) => e['amount'] as double).reduce((a, b) => a > b ? a : b) * 1.2 : 1000,
                          ),
                        ),
                        if (!hasData)
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bar_chart,
                                  size: 48,
                                  color: BaakasColors.primaryColor.withOpacity(0.3),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'No earnings data yet',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Start selling to see your earnings',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        const SizedBox(height: BaakasSizes.spaceBtwSections),
        
        // Earnings Cards Row
        Row(
          children: [
            // Total Earnings Card
            Expanded(
              child: Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Earnings',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: BaakasSizes.spaceBtwItems),
                      Obx(() => Text(
                        'Rs ${BaakasHelperFunctions.formatNumber(controller.totalEarnings)}',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: BaakasColors.primaryColor,
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: BaakasSizes.spaceBtwItems),
            // Pending Earnings Card
            Expanded(
              child: Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Pending',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: BaakasSizes.spaceBtwItems),
                      Obx(() => Text(
                        'Rs ${BaakasHelperFunctions.formatNumber(controller.pendingEarnings)}',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: BaakasColors.warning,
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}