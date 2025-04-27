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
    final isDark = BaakasHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Weekly Earnings Graph
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BaakasSizes.cardRadiusLg),
          ),
          child: Padding(
            padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weekly Earnings',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: isDark ? BaakasColors.white : BaakasColors.dark,
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
                                  color: BaakasColors.primaryColor.withValues(alpha: 77),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'No earnings data yet',
                                  style: TextStyle(
                                    color: isDark ? BaakasColors.white : BaakasColors.dark,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Start selling to see your earnings',
                                  style: TextStyle(
                                    color: isDark ? BaakasColors.white.withValues(alpha: 128) : BaakasColors.dark.withValues(alpha: 128),
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
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BaakasSizes.cardRadiusLg),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
                  decoration: BoxDecoration(
                    color: isDark ? BaakasColors.dark : BaakasColors.white,
                    borderRadius: BorderRadius.circular(BaakasSizes.cardRadiusLg),
                    border: Border.all(
                      color: isDark ? BaakasColors.darkGrey : BaakasColors.grey.withValues(alpha: 51),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Revenue',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: isDark ? BaakasColors.white : BaakasColors.dark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: BaakasSizes.spaceBtwItems),
                      Flexible(
                        child: Obx(() => Text(
                          'Rs ${BaakasHelperFunctions.formatNumber(controller.totalEarnings)}',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: BaakasColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: BaakasSizes.spaceBtwItems),
            // Pending Earnings Card
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BaakasSizes.cardRadiusLg),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
                  decoration: BoxDecoration(
                    color: isDark ? BaakasColors.dark : BaakasColors.white,
                    borderRadius: BorderRadius.circular(BaakasSizes.cardRadiusLg),
                    border: Border.all(
                      color: isDark ? BaakasColors.darkGrey : BaakasColors.grey.withValues(alpha: 51),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pending',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: isDark ? BaakasColors.white : BaakasColors.dark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: BaakasSizes.spaceBtwItems),
                      Flexible(
                        child: Obx(() => Text(
                          'Rs ${BaakasHelperFunctions.formatNumber(controller.pendingEarnings)}',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: BaakasColors.warning,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )),
                      ),
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