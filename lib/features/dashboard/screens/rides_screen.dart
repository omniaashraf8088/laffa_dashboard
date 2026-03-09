import 'package:flutter/material.dart';
import '../../../core/services/demo_data_service.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../widgets/status_badge.dart';
import '../widgets/dashboard_data_table.dart';
import '../widgets/filter_chip_bar.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  String _statusFilter = AppStrings.filterAll;
  final _allRides = DemoDataService.getRides();

  @override
  Widget build(BuildContext context) {
    final filteredRides = _statusFilter == AppStrings.filterAll
        ? _allRides
        : _allRides.where((r) => r.status == _statusFilter).toList();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Filter chips
          FilterChipBar(
            filters: const [
              AppStrings.filterAll,
              AppStrings.filterCompleted,
              AppStrings.filterInProgress,
              AppStrings.filterCancelled,
            ],
            selected: _statusFilter,
            onSelected: (v) => setState(() => _statusFilter = v),
          ),
          const SizedBox(height: 16),
          // Table
          Expanded(
            child: DashboardDataTable(
              columns: const [
                AppStrings.colId,
                AppStrings.colRider,
                AppStrings.colDriver,
                AppStrings.colPickup,
                AppStrings.colDropoff,
                AppStrings.colFare,
                AppStrings.colStatus,
                AppStrings.colDate,
              ],
              sortableColumns: const [0, 5, 7],
              searchHint: AppStrings.searchRides,
              rows: filteredRides.map((r) {
                return [
                  Text(r.id),
                  Text(r.userName),
                  Text(r.driverName),
                  Text(r.pickup, overflow: TextOverflow.ellipsis),
                  Text(r.dropoff, overflow: TextOverflow.ellipsis),
                  Text(
                    Formatters.currency(r.fare),
                    style: AppTextStyles.cellHighlight,
                  ),
                  StatusBadge(status: r.status),
                  Text(Formatters.date(r.date)),
                ];
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
