import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/services/demo_data_service.dart';
import '../../../core/utils/formatters.dart';
import '../widgets/glass_chart_container.dart';
import '../widgets/chart_legend.dart';

/// Revenue trend line chart for the Analytics screen.
class AnalyticsRevenueChart extends StatelessWidget {
  final Animation<double> animation;

  const AnalyticsRevenueChart({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    final data = DemoDataService.getMonthlyRevenue();
    final months = DemoDataService.months;

    return GlassChartContainer(
      title: AppStrings.revenueTrend,
      subtitle: AppStrings.revenuePerformance,
      icon: Icons.trending_up_rounded,
      delay: 0,
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
                  getDrawingHorizontalLine: (v) => FlLine(
                    color: AppColors.gridLine,
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (v, _) => Text(
                        '\$${(v / 1000).toStringAsFixed(0)}k',
                        style: AppTextStyles.axisLabel,
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        final i = v.toInt();
                        if (i < 0 || i >= months.length) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            months[i],
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
                    spots: data.asMap().entries.map((e) {
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
                    getTooltipItems: (spots) => spots.map((s) {
                      return LineTooltipItem(
                        '${months[s.x.toInt()]}\n',
                        AppTextStyles.tooltipLabel,
                        children: [
                          TextSpan(
                            text: Formatters.currency(s.y),
                            style: AppTextStyles.tooltipValue,
                          ),
                        ],
                      );
                    }).toList(),
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

/// Monthly rides bar chart for the Analytics screen.
class AnalyticsRidesBarChart extends StatelessWidget {
  final Animation<double> animation;

  const AnalyticsRidesBarChart({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    final data = DemoDataService.getMonthlyRides();
    final months = DemoDataService.months;

    return GlassChartContainer(
      title: AppStrings.monthlyRides,
      subtitle: AppStrings.ridesPerMonth,
      icon: Icons.directions_car_rounded,
      delay: 200,
      chart: SizedBox(
        height: 280,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return BarChart(
              BarChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (v) => FlLine(
                    color: AppColors.gridLine,
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 44,
                      getTitlesWidget: (v, _) => Text(
                        '${(v / 1000).toStringAsFixed(1)}k',
                        style: AppTextStyles.axisLabel,
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        final i = v.toInt();
                        if (i < 0 || i >= months.length) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            months[i],
                            style: AppTextStyles.axisLabel.copyWith(
                              fontSize: 10,
                            ),
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
                barGroups: data.asMap().entries.map((e) {
                  return BarChartGroupData(
                    x: e.key,
                    barRods: [
                      BarChartRodData(
                        toY: e.value * animation.value,
                        width: 16,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                        gradient: const LinearGradient(
                          colors: [AppColors.purple, AppColors.purpleLight],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ],
                  );
                }).toList(),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => AppColors.surfaceLight,
                    tooltipRoundedRadius: 12,
                    getTooltipItem: (group, groupIdx, rod, rodIdx) {
                      return BarTooltipItem(
                        '${months[group.x]}\n',
                        AppTextStyles.tooltipLabel,
                        children: [
                          TextSpan(
                            text: Formatters.number(rod.toY),
                            style: AppTextStyles.tooltipValue,
                          ),
                          const TextSpan(
                            text: AppStrings.rides,
                            style: AppTextStyles.tooltipLabel,
                          ),
                        ],
                      );
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

/// Ride distribution pie chart for the Analytics screen.
class AnalyticsPieChart extends StatelessWidget {
  final Animation<double> animation;

  const AnalyticsPieChart({super.key, required this.animation});

  static const _colors = [
    AppColors.success,
    AppColors.info,
    AppColors.error,
    AppColors.warning,
  ];

  @override
  Widget build(BuildContext context) {
    final dist = DemoDataService.getRideStatusDistribution();

    return GlassChartContainer(
      title: AppStrings.rideDistribution,
      subtitle: AppStrings.statusBreakdown,
      icon: Icons.pie_chart_rounded,
      delay: 400,
      chart: Column(
        children: [
          SizedBox(
            height: 220,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, _) {
                return PieChart(
                  PieChartData(
                    sectionsSpace: 4,
                    centerSpaceRadius: 50,
                    sections: dist.entries.toList().asMap().entries.map((
                      entry,
                    ) {
                      return PieChartSectionData(
                        color: _colors[entry.key % _colors.length],
                        value: entry.value.value * animation.value,
                        title: '${entry.value.value.toInt()}%',
                        radius: 55,
                        titleStyle: AppTextStyles.pieSectionLabel,
                      );
                    }).toList(),
                    pieTouchData: PieTouchData(
                      touchCallback: (event, response) {},
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ChartLegend(data: dist, colors: _colors, compact: true),
        ],
      ),
    );
  }
}

/// Weekly new-users bar chart for the Analytics screen.
class AnalyticsWeeklyUsersChart extends StatelessWidget {
  final Animation<double> animation;

  const AnalyticsWeeklyUsersChart({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    final data = DemoDataService.getWeeklyUsers();
    final days = DemoDataService.weekDays;

    return GlassChartContainer(
      title: AppStrings.weeklyNewUsers,
      subtitle: AppStrings.weeklyRegistrations,
      icon: Icons.people_rounded,
      delay: 600,
      chart: SizedBox(
        height: 280,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return BarChart(
              BarChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (v) => FlLine(
                    color: AppColors.gridLine,
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (v, _) => Text(
                        v.toInt().toString(),
                        style: AppTextStyles.axisLabel,
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        final i = v.toInt();
                        if (i < 0 || i >= days.length) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(days[i], style: AppTextStyles.axisLabel),
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
                barGroups: data.asMap().entries.map((e) {
                  return BarChartGroupData(
                    x: e.key,
                    barRods: [
                      BarChartRodData(
                        toY: e.value * animation.value,
                        width: 28,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        gradient: const LinearGradient(
                          colors: [AppColors.cyan, AppColors.purpleLight],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ],
                  );
                }).toList(),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => AppColors.surfaceLight,
                    tooltipRoundedRadius: 12,
                    getTooltipItem: (group, groupIdx, rod, rodIdx) {
                      return BarTooltipItem(
                        '${days[group.x]}\n',
                        AppTextStyles.tooltipLabel,
                        children: [
                          TextSpan(
                            text: '${rod.toY.toInt()}${AppStrings.users}',
                            style: AppTextStyles.tooltipValue,
                          ),
                        ],
                      );
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
