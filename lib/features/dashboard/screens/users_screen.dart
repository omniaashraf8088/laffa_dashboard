import 'package:flutter/material.dart';
import '../../../core/services/demo_data_service.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../widgets/status_badge.dart';
import '../widgets/dashboard_data_table.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final users = DemoDataService.getUsers();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: DashboardDataTable(
        columns: const [
          AppStrings.colId,
          AppStrings.colName,
          AppStrings.colEmail,
          AppStrings.colPhone,
          AppStrings.colStatus,
          AppStrings.colJoined,
          AppStrings.colRides,
        ],
        sortableColumns: const [0, 1, 5, 6],
        searchHint: AppStrings.searchUsers,
        rows: users.map((u) {
          return [
            Text(u.id),
            Text(u.name, style: AppTextStyles.cellBold),
            Text(u.email),
            Text(u.phone),
            StatusBadge(status: u.status),
            Text(Formatters.date(u.joinedDate)),
            Text(u.totalRides.toString()),
          ];
        }).toList(),
      ),
    );
  }
}
