import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/services/demo_data_service.dart';
import '../../../core/utils/formatters.dart';
import '../widgets/summary_card.dart';
import '../widgets/page_header.dart';
import '../widgets/home_charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _stats = DemoDataService.getStats();
  late AnimationController _chartAnimController;
  late Animation<double> _chartAnimation;

  @override
  void initState() {
    super.initState();
    _chartAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _chartAnimation = CurvedAnimation(
      parent: _chartAnimController,
      curve: Curves.easeOutCubic,
    );
    _chartAnimController.forward();
  }

  @override
  void dispose() {
    _chartAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome section
          _buildWelcomeHeader(),
          const SizedBox(height: 28),

          // Summary Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 1000
                  ? 4
                  : constraints.maxWidth > 600
                  ? 2
                  : 1;
              final childAspectRatio = constraints.maxWidth > 1000 ? 1.6 : 1.8;
              return GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: childAspectRatio,
                children: [
                  SummaryCard(
                    title: AppStrings.totalUsers,
                    value: Formatters.number(_stats.totalUsers),
                    icon: Icons.people_rounded,
                    gradient: AppColors.cardGradient1,
                    subtitle: '+12.5%',
                    animationDelay: 0,
                  ),
                  SummaryCard(
                    title: AppStrings.totalRides,
                    value: Formatters.number(_stats.totalRides),
                    icon: Icons.directions_car_rounded,
                    gradient: AppColors.cardGradient2,
                    subtitle: '+8.3%',
                    animationDelay: 120,
                  ),
                  SummaryCard(
                    title: AppStrings.totalRevenue,
                    value: Formatters.currency(_stats.totalRevenue),
                    icon: Icons.attach_money_rounded,
                    gradient: AppColors.cardGradient3,
                    subtitle: '+15.2%',
                    animationDelay: 240,
                  ),
                  SummaryCard(
                    title: AppStrings.activeDrivers,
                    value: Formatters.number(_stats.activeDrivers),
                    icon: Icons.person_pin_rounded,
                    gradient: AppColors.cardGradient4,
                    subtitle: '+5.7%',
                    animationDelay: 360,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),

          // Charts row
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: HomeRevenueChart(animation: _chartAnimation),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: HomeRidesPieChart(animation: _chartAnimation),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  HomeRevenueChart(animation: _chartAnimation),
                  const SizedBox(height: 20),
                  HomeRidesPieChart(animation: _chartAnimation),
                ],
              );
            },
          ),
          const SizedBox(height: 32),

          // Recent activity
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Row(
          children: [
            const PageHeader(
              title: AppStrings.dashboardOverview,
              subtitle: AppStrings.realtimeMetrics,
            ),
            const SizedBox(width: 12),
            _LiveBadge(),
          ],
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideX(begin: -0.05, end: 0, curve: Curves.easeOut);
  }

  Widget _buildRecentActivity() {
    final rides = DemoDataService.getRides().take(5).toList();

    return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    AppStrings.recentRides,
                    style: AppTextStyles.sectionTitle,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.purpleBadge,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${rides.length} latest',
                      style: AppTextStyles.badgePurple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              ...rides.asMap().entries.map((entry) {
                final ride = entry.value;
                return _RecentRideItem(ride: ride, index: entry.key);
              }),
            ],
          ),
        )
        .animate(delay: 650.ms)
        .fadeIn(duration: 700.ms)
        .slideY(begin: 0.08, end: 0);
  }
}

class _RecentRideItem extends StatefulWidget {
  final dynamic ride;
  final int index;
  const _RecentRideItem({required this.ride, required this.index});

  @override
  State<_RecentRideItem> createState() => _RecentRideItemState();
}

class _RecentRideItemState extends State<_RecentRideItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final ride = widget.ride;
    final statusColor = _statusColor(ride.status);

    return MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppColors.purpleHover
                  : AppColors.surfaceLight.withAlpha(150),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _hovered ? AppColors.purpleBorder : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(_hovered ? 40 : 25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: statusColor.withAlpha(_hovered ? 60 : 0),
                    ),
                  ),
                  child: Icon(
                    Icons.directions_car_rounded,
                    color: statusColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ride.userName, style: AppTextStyles.itemTitle),
                      const SizedBox(height: 2),
                      Text(
                        '${ride.pickup} → ${ride.dropoff}',
                        style: AppTextStyles.itemSubtitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Formatters.currency(ride.fare),
                      style: AppTextStyles.tooltipValue,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      ride.status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        .animate(delay: Duration(milliseconds: 700 + widget.index * 80))
        .fadeIn(duration: 450.ms)
        .slideX(begin: 0.04, end: 0, curve: Curves.easeOutCubic);
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Completed':
        return AppColors.success;
      case 'In Progress':
        return AppColors.info;
      case 'Cancelled':
        return AppColors.error;
      default:
        return AppColors.warning;
    }
  }
}

/// Green pulsing "Live" badge shown next to the dashboard header.
class _LiveBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.success, Color(0xFF81C784)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                AppStrings.live,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .fadeIn(duration: 1200.ms, begin: 0.6);
  }
}
