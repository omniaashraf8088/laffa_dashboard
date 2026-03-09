import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../widgets/page_header.dart';
import '../widgets/analytics_charts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _anim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: AppStrings.analytics,
            badgeText: AppStrings.chartsCount,
            subtitle: AppStrings.detailedMetrics,
          ),
          const SizedBox(height: 28),

          // Row 1: Line chart + Bar chart
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: AnalyticsRevenueChart(animation: _anim)),
                    const SizedBox(width: 20),
                    Expanded(child: AnalyticsRidesBarChart(animation: _anim)),
                  ],
                );
              }
              return Column(
                children: [
                  AnalyticsRevenueChart(animation: _anim),
                  const SizedBox(height: 20),
                  AnalyticsRidesBarChart(animation: _anim),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          // Row 2: Pie chart + Weekly users
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: AnalyticsPieChart(animation: _anim)),
                    const SizedBox(width: 20),
                    Expanded(
                      child: AnalyticsWeeklyUsersChart(animation: _anim),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  AnalyticsPieChart(animation: _anim),
                  const SizedBox(height: 20),
                  AnalyticsWeeklyUsersChart(animation: _anim),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
