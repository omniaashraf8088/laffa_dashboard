import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/services/demo_data_service.dart';
import '../../../core/utils/formatters.dart';
import '../widgets/glass_chart_container.dart';
import '../widgets/chart_legend.dart';

/// Revenue line chart used on the Home screen.
class HomeRevenueChart extends StatelessWidget {
  final Animation<double> animation;

  const HomeRevenueChart({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    final revenue = DemoDataService.getMonthlyRevenue();
    final months = DemoDataService.months;

    return GlassChartContainer(
      title: AppStrings.monthlyRevenue,
      subtitle: AppStrings.revenueOverview,
      delay: 400,
      chart: SizedBox(
        height: 280,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) =>
                      FlLine(color: AppColors.gridLine, strokeWidth: 1),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) => Text(
                        '\$${(value / 1000).toStringAsFixed(0)}k',
                        style: AppTextStyles.axisLabel,
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx < 0 || idx >= months.length) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            months[idx],
                            style: AppTextStyles.axisLabel,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: revenue.asMap().entries.map((e) {
                      return FlSpot(
                        e.key.toDouble(),
                        e.value * animation.value,
                      );
                    }).toList(),
                    isCurved: true,
                    gradient: const LinearGradient(
                      colors: [AppColors.purple, AppColors.cyan],
                    ),
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, xPercentage, bar, index) =>
                          FlDotCirclePainter(
                            radius: 4,
                            color: AppColors.cyan,
                            strokeWidth: 2,
                            strokeColor: AppColors.surface,
                          ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.areaGradientStart,
                          AppColors.areaGradientEnd,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => AppColors.surfaceLight,
                    tooltipRoundedRadius: 12,
                    getTooltipItems: (spots) {
                      return spots.map((spot) {
                        return LineTooltipItem(
                          '${months[spot.x.toInt()]}\n',
                          AppTextStyles.tooltipLabel,
                          children: [
                            TextSpan(
                              text: Formatters.currency(spot.y),
                              style: AppTextStyles.tooltipValue,
                            ),
                          ],
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Ride-status pie chart used on the Home screen.
class HomeRidesPieChart extends StatelessWidget {
  final Animation<double> animation;

  const HomeRidesPieChart({super.key, required this.animation});

  static const _colors = [
    AppColors.success,
    AppColors.info,
    AppColors.error,
    AppColors.warning,
  ];

  @override
  Widget build(BuildContext context) {
    final distribution = DemoDataService.getRideStatusDistribution();

    return GlassChartContainer(
      title: AppStrings.rideStatus,
      subtitle: AppStrings.distributionBreakdown,
      delay: 500,
      chart: Column(
        children: [
          SizedBox(
            height: 200,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, _) {
                return PieChart(
                  PieChartData(
                    sectionsSpace: 3,
                    centerSpaceRadius: 42,
                    sections: distribution.entries.toList().asMap().entries.map(
                      (entry) {
                        return PieChartSectionData(
                          color: _colors[entry.key % _colors.length],
                          value: entry.value.value * animation.value,
                          title: '${entry.value.value.toInt()}%',
                          radius: 52,
                          titleStyle: AppTextStyles.pieSectionLabel,
                        );
                      },
                    ).toList(),
                    pieTouchData: PieTouchData(
                      touchCallback: (event, response) {},
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ChartLegend(data: distribution, colors: _colors),
        ],
      ),
    );
  }
}
