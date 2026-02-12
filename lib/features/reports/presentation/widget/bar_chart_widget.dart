import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/reports/domain/entities/report_bar_entry.dart';

class BarChartWidget extends StatefulWidget {
  final List<ReportBarEntry> entries;

  const BarChartWidget({super.key, required this.entries});

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}
class _BarChartWidgetState extends State<BarChartWidget> {
  int? _touchedIndex;
  bool _barTappedThisGesture = false;
  DateTime _selectedMonth = DateTime.now();

  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  Future<void> _pickMonth(BuildContext context) async {
    final picked = await showMonthPicker(
      context: context,
      initialDate: _selectedMonth,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2035, 12),
      
      monthPickerDialogSettings: MonthPickerDialogSettings(
        headerSettings: PickerHeaderSettings(
            // hideHeaderRow: true,
            // hideHeaderArrows: false,
        
          headerBackgroundColor: AppColors.primary,
          headerCurrentPageTextStyle: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
          headerSelectedIntervalTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),

        ),
        
        dialogSettings: PickerDialogSettings(
          blockScrolling: false
          ,verticalScrolling: true,
          dialogRoundedCornersRadius: 10,
          dialogBackgroundColor: AppColors.onPrimary,

        ),
        dateButtonsSettings: PickerDateButtonsSettings(

          selectedMonthBackgroundColor: AppColors.primary,
          selectedMonthTextColor: Colors.white,
          unselectedMonthsTextColor: AppColors.onBackgroundLight,
          currentMonthTextColor: AppColors.primary,
          yearTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.onBackgroundLight,
          ),
          monthTextStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          
          buttonBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );

    if (picked == null) {
      return;
    }

    setState(() {
      _selectedMonth = DateTime(picked.year, picked.month);
    });
  }

  String get _monthLabel =>
      '${_monthNames[_selectedMonth.month - 1]} ${_selectedMonth.year}';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (_) => _barTappedThisGesture = false,
      onTapCancel: () => _barTappedThisGesture = false,
      onTapUp: (_) {
        if (!_barTappedThisGesture && _touchedIndex != null) {
          setState(() => _touchedIndex = null);
        }
        _barTappedThisGesture = false;
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.onPrimary,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$11,740",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Total Spend",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.subtitleTextColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => _pickMonth(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.onPrimaryLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _monthLabel,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 13,
                          color: AppColors.subtitleTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: AppColors.subtitleTextColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY:
                    widget.entries
                        .map((entry) => entry.value)
                        .reduce((a, b) => a > b ? a : b) *
                    1.2,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: const FlTitlesData(
                  show: false,
                ),
                barTouchData: BarTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchCallback: (event, response) {
                    if (event is! FlTapUpEvent) {
                      return;
                    }

                    final spot = response?.spot;
                    if (spot == null) {
                      return;
                    }

                    _barTappedThisGesture = true;
                    final touchedIndex = spot.touchedBarGroupIndex;
                    if (touchedIndex != _touchedIndex) {
                      setState(() => _touchedIndex = touchedIndex);
                    }
                  },
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => Colors.black,
                    tooltipPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    tooltipMargin: 12,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final entry = widget.entries[groupIndex];
                      return BarTooltipItem(
                        '${entry.label}\nThis mo: \$${entry.value.toStringAsFixed(2)}',
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                ),
                barGroups: List.generate(widget.entries.length, (index) {
                  final entry = widget.entries[index];
                  final isDimmed =
                      _touchedIndex != null && _touchedIndex != index;
                  return BarChartGroupData(
                    x: index,
                    showingTooltipIndicators: index == _touchedIndex
                        ? const [0]
                        : const [],
                    barRods: [
                      BarChartRodData(
                        toY: entry.value,
                        width: 18,
                        borderRadius: BorderRadius.circular(12),
                        color: isDimmed
                            ? AppColors.onPrimaryLight
                            : AppColors.primary,
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY:
                              widget.entries
                                  .map((entry) => entry.value)
                                  .reduce((a, b) => a > b ? a : b) *
                              1.2,
                          color: AppColors.onPrimaryLight.withOpacity(0.4),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
