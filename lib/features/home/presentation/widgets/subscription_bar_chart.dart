import 'dart:convert';
import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/home/domain/entities/subscription.dart';

class SubscriptionBarChart extends StatefulWidget {
  final List<Subscription> subscriptions;
  final bool showInactive;

  const SubscriptionBarChart({
    super.key,
    required this.subscriptions,
    this.showInactive = true,
  });

  @override
  State<SubscriptionBarChart> createState() => _SubscriptionBarChartState();
}

class _SubscriptionBarChartState extends State<SubscriptionBarChart>
    with SingleTickerProviderStateMixin {
  // Cache for decoded base64 images
  final Map<String, Uint8List?> _imageCache = {};

  // Animation controller for bar entry animation
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _preloadImages();

    // Initialize animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    // Start animation
    _animationController.forward();
  }

  @override
  void didUpdateWidget(SubscriptionBarChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reload images if subscriptions changed
    if (widget.subscriptions != oldWidget.subscriptions) {
      _imageCache.clear();
      _preloadImages();
      // Restart animation for new data
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Preload and cache all base64 images
  void _preloadImages() {
    for (final subscription in widget.subscriptions) {
       try {
          final base64Data = subscription.icon.split(',').last;
          _imageCache[subscription.icon] = base64Decode(base64Data);
        } catch (e) {
          _imageCache[subscription.icon] = null;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.subscriptions.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.onPrimary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.2),
            width: 2,
          ),
        ),
        height: 180,
        child: const Center(
          child: Text('No subscription data available'),
        ),
      );
    }

    // Calculate max value for chart scaling
    final maxAmount = widget.subscriptions
        .map((s) => s.amount)
        .reduce((a, b) => a > b ? a : b);
    final chartMaxY = (maxAmount * 1.2).ceilToDouble();

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Generate bar groups dynamically with animation
        final barGroups = List.generate(
          widget.subscriptions.length,
          (index) {
            final subscription = widget.subscriptions[index];
            // Animate the bar value from 0 to actual value
            final animatedValue = subscription.amount * _animation.value;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: animatedValue,
                  color: AppColors.primary,
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: chartMaxY,
                    color: const Color(0xffECF0F6),
                  ),
                  width: 32,
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            );
          },
        );

        return _buildChartContainer(chartMaxY, barGroups);
      },
    );
  }

  Widget _buildChartContainer(
    double chartMaxY,
    List<BarChartGroupData> barGroups,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.primary.withOpacity(0.10),
        //     offset: const Offset(0, 1),
        //     blurRadius: 30,
        //     spreadRadius: 2,
        //   ),
        // ],
      ),
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: chartMaxY,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => AppColors.primary.withOpacity(0.8),
              tooltipPadding: const EdgeInsets.all(8),
              tooltipMargin: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final subscription = widget.subscriptions[groupIndex];
                return BarTooltipItem(
                  '${subscription.name}\n\$${rod.toY.toStringAsFixed(2)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < widget.subscriptions.length) {
                    final subscription = widget.subscriptions[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        width: 36,
                        height: 36,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.onPrimaryLight,
                          shape: BoxShape.circle,
                        ),
                        child: _buildIcon(subscription.icon),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
                reservedSize: 50,
              ),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: barGroups,
        ),
      ),
    );
  }

  /// Helper method to build icon widget from emoji or base64 image
  Widget _buildIcon(String icon) {
    final bytes = _imageCache[icon];

    if (bytes != null) {
      // Use cached decoded image
      return ClipOval(
        child: Image.memory(
          bytes,
          fit: BoxFit.cover,
          gaplessPlayback: true, // Prevents flickering
          errorBuilder: (context, error, stackTrace) {
            // Fallback to text if image fails to load
            return Center(
              child: Text(
                '?',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.primary,
                ),
              ),
            );
          },
        ),
      );
    } else {
      // Image failed to decode or is still loading
      return Center(
        child: Text(
          '?',
          style: TextStyle(
            fontSize: 20,
            color: AppColors.primary,
          ),
        ),
      );
    }
  }
}
