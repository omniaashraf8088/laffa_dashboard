import 'package:flutter/material.dart';
import '../../../core/services/demo_data_service.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../widgets/status_badge.dart';
import '../widgets/dashboard_data_table.dart';
import '../widgets/filter_chip_bar.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  String _statusFilter = AppStrings.filterAll;
  final _allPayments = DemoDataService.getPayments();

  @override
  Widget build(BuildContext context) {
    final filtered = _statusFilter == AppStrings.filterAll
        ? _allPayments
        : _allPayments.where((p) => p.status == _statusFilter).toList();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Filter chips
          FilterChipBar(
            filters: const [
              AppStrings.filterAll,
              AppStrings.filterCompleted,
              AppStrings.filterPending,
              AppStrings.filterRefunded,
              AppStrings.filterFailed,
            ],
            selected: _statusFilter,
            onSelected: (v) => setState(() => _statusFilter = v),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: DashboardDataTable(
              columns: const [
                AppStrings.colId,
                AppStrings.colUser,
                AppStrings.colRideId,
                AppStrings.colAmount,
                AppStrings.colMethod,
                AppStrings.colStatus,
                AppStrings.colDate,
              ],
              sortableColumns: const [0, 3, 6],
              searchHint: AppStrings.searchPayments,
              rows: filtered.map((p) {
                return [
                  Text(p.id),
                  Text(p.userName),
                  Text(p.rideId),
                  Text(
                    Formatters.currency(p.amount),
                    style: AppTextStyles.cellHighlight,
                  ),
                  _buildMethodChip(p.method),
                  StatusBadge(status: p.status),
                  Text(Formatters.date(p.date)),
                ];
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodChip(String method) {
    IconData icon;
    switch (method) {
      case 'Credit Card':
        icon = Icons.credit_card;
        break;
      case 'Debit Card':
        icon = Icons.credit_card_outlined;
        break;
      case 'Cash':
        icon = Icons.money;
        break;
      case 'Wallet':
        icon = Icons.account_balance_wallet;
        break;
      default:
        icon = Icons.payment;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.textMuted),
        const SizedBox(width: 6),
        Text(method, style: AppTextStyles.cellBody),
      ],
    );
  }
}
