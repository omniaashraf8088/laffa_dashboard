import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';

/// A reusable animated data table with search, sort, pagination, and neon hover.
class DashboardDataTable extends StatefulWidget {
  final List<String> columns;
  final List<List<Widget>> rows;
  final List<int> sortableColumns;
  final String searchHint;

  const DashboardDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.sortableColumns = const [],
    this.searchHint = AppStrings.searchDefault,
  });

  @override
  State<DashboardDataTable> createState() => _DashboardDataTableState();
}

class _DashboardDataTableState extends State<DashboardDataTable> {
  String _searchQuery = '';
  int _currentPage = 0;
  int _sortColumn = -1;
  bool _sortAscending = true;
  int _hoveredRow = -1;
  static const _rowsPerPage = 10;
  bool _searchFocused = false;

  List<List<Widget>> get _filteredRows {
    if (_searchQuery.isEmpty) return widget.rows;
    return widget.rows.where((row) {
      return row.any((cell) {
        if (cell is Text) {
          return cell.data?.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ??
              false;
        }
        return false;
      });
    }).toList();
  }

  List<List<Widget>> get _paginatedRows {
    final start = _currentPage * _rowsPerPage;
    final end = (start + _rowsPerPage).clamp(0, _filteredRows.length);
    if (start >= _filteredRows.length) return [];
    return _filteredRows.sublist(start, end);
  }

  int get _totalPages => (_filteredRows.length / _rowsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withAlpha(200),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.overlayWhiteFaint.withAlpha(8)),
        boxShadow: [
          BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 30,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Animated search bar
          Padding(
            padding: const EdgeInsets.all(18),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _searchFocused
                      ? AppColors.purpleIndicator
                      : Colors.white.withAlpha(8),
                ),
                boxShadow: _searchFocused
                    ? [
                        BoxShadow(
                          color: AppColors.purple.withAlpha(20),
                          blurRadius: 16,
                          spreadRadius: -4,
                        ),
                      ]
                    : null,
              ),
              child: Focus(
                onFocusChange: (f) => setState(() => _searchFocused = f),
                child: TextField(
                  onChanged: (v) => setState(() {
                    _searchQuery = v;
                    _currentPage = 0;
                  }),
                  decoration: InputDecoration(
                    hintText: widget.searchHint,
                    prefixIcon: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: _searchFocused
                            ? [AppColors.purple, AppColors.cyan]
                            : [AppColors.textMuted, AppColors.textMuted],
                      ).createShader(bounds),
                      child: const Icon(Icons.search, color: Colors.white),
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear_rounded,
                              color: AppColors.textMuted,
                              size: 18,
                            ),
                            onPressed: () => setState(() {
                              _searchQuery = '';
                              _currentPage = 0;
                            }),
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    hintStyle: AppTextStyles.searchHint,
                  ),
                  style: AppTextStyles.searchInput,
                ),
              ),
            ),
          ),

          // Table
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header with gradient accent
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight.withAlpha(100),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.overlayWhiteFaint),
                    ),
                    child: Row(
                      children: widget.columns.asMap().entries.map((e) {
                        final isSortable = widget.sortableColumns.contains(
                          e.key,
                        );
                        final isSorted = _sortColumn == e.key;
                        return Expanded(
                          child: InkWell(
                            onTap: isSortable
                                ? () => setState(() {
                                    if (_sortColumn == e.key) {
                                      _sortAscending = !_sortAscending;
                                    } else {
                                      _sortColumn = e.key;
                                      _sortAscending = true;
                                    }
                                  })
                                : null,
                            child: Row(
                              children: [
                                Text(
                                  e.value,
                                  style: AppTextStyles.tableHeader.copyWith(
                                    color: isSorted
                                        ? AppColors.cyan
                                        : AppColors.textSecondary,
                                  ),
                                ),
                                if (isSortable) ...[
                                  const SizedBox(width: 4),
                                  AnimatedRotation(
                                    turns: isSorted && !_sortAscending
                                        ? 0.5
                                        : 0,
                                    duration: const Duration(milliseconds: 250),
                                    child: Icon(
                                      Icons.arrow_upward_rounded,
                                      size: 14,
                                      color: isSorted
                                          ? AppColors.cyan
                                          : AppColors.textMuted.withAlpha(60),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  // Rows with neon hover
                  ..._paginatedRows.asMap().entries.map((entry) {
                    final index = entry.key;
                    final row = entry.value;
                    final isHovered = _hoveredRow == index;
                    return MouseRegion(
                          onEnter: (_) => setState(() => _hoveredRow = index),
                          onExit: (_) => setState(() => _hoveredRow = -1),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOutCubic,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 1,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: isHovered
                                  ? AppColors.purple.withAlpha(18)
                                  : Colors.transparent,
                              border: Border(
                                left: BorderSide(
                                  color: isHovered
                                      ? AppColors.purple
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                bottom: BorderSide(color: AppColors.gridLine),
                              ),
                            ),
                            child: Row(
                              children: row
                                  .map((cell) => Expanded(child: cell))
                                  .toList(),
                            ),
                          ),
                        )
                        .animate(delay: Duration(milliseconds: index * 40))
                        .fadeIn(duration: 350.ms)
                        .slideX(begin: 0.015, end: 0);
                  }),
                ],
              ),
            ),
          ),

          // Pagination with improved design
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.gridLine)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${_filteredRows.isEmpty ? 0 : _currentPage * _rowsPerPage + 1}-'
                  '${((_currentPage + 1) * _rowsPerPage).clamp(0, _filteredRows.length)} '
                  'of ${_filteredRows.length}',
                  style: AppTextStyles.paginationInfo,
                ),
                Row(
                  children: [
                    _PaginationArrow(
                      icon: Icons.chevron_left_rounded,
                      enabled: _currentPage > 0,
                      onTap: () => setState(() => _currentPage--),
                    ),
                    ...List.generate(_totalPages.clamp(0, 5), (i) {
                      final page = i;
                      final isActive = _currentPage == page;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: GestureDetector(
                          onTap: () => setState(() => _currentPage = page),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 34,
                            height: 34,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: isActive
                                  ? const LinearGradient(
                                      colors: [
                                        AppColors.purple,
                                        AppColors.purpleLight,
                                      ],
                                    )
                                  : null,
                              color: isActive ? null : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: AppColors.purpleIndicator,
                                        blurRadius: 10,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Text(
                              '${page + 1}',
                              style: TextStyle(
                                color: isActive
                                    ? Colors.white
                                    : AppColors.textMuted,
                                fontSize: 13,
                                fontWeight: isActive
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    _PaginationArrow(
                      icon: Icons.chevron_right_rounded,
                      enabled: _currentPage < _totalPages - 1,
                      onTap: () => setState(() => _currentPage++),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaginationArrow extends StatefulWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;
  const _PaginationArrow({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  State<_PaginationArrow> createState() => _PaginationArrowState();
}

class _PaginationArrowState extends State<_PaginationArrow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _hovered && widget.enabled
                ? AppColors.purpleSubtle
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            widget.icon,
            size: 20,
            color: widget.enabled
                ? (_hovered ? AppColors.purple : AppColors.textMuted)
                : AppColors.textMuted.withAlpha(50),
          ),
        ),
      ),
    );
  }
}
