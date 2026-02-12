import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:subscription_manager/app/app_route.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/core/constant/demo.dart';
import 'package:subscription_manager/features/home/domain/entities/subscription.dart';
import 'package:subscription_manager/features/home/presentation/widgets/all_subscriptions.dart';
import 'package:subscription_manager/features/home/presentation/widgets/subscription_bar_chart.dart';
import 'package:subscription_manager/features/home/presentation/widgets/upcomings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isFabVisible = ValueNotifier(true);
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isFabVisible.value) {
        _isFabVisible.value = false;
        if (_isExpanded.value) {
          _isExpanded.value = false;
          _animationController.reverse();
        }
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isFabVisible.value) {
        _isFabVisible.value = true;
      }
    }
  }

  void _toggleExpanded() {
    _isExpanded.value = !_isExpanded.value;
    if (_isExpanded.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    _isFabVisible.dispose();
    _isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sample subscription data (replace with actual data from your state management)
    final subscriptions = [
      Subscription(
        name: 'Netflix',
        amount: 85.0,
        icon: demoImageBase64,
        color: Color(0xFFE50914),
      ),
      Subscription(
        name: 'Figma',
        amount: 70.0,
        icon: demoImageBase64,
        color: Color(0xFF0ACF83),
      ),
      Subscription(
        name: 'Spotify',
        amount: 55.0,
        icon: demoImageBase64,
        color: Color(0xFF1DB954),
      ),
      Subscription(
        name: 'YouTube',
        amount: 50.0,
        icon: demoImageBase64,
        color: Color(0xFFFF0000),
      ),
      Subscription(
        name: 'Discord',
        amount: 60.0,
        icon: demoImageBase64,
        color: Color(0xFF5865F2),
      ),
      Subscription(
        name: 'Adobe',
        amount: 45.0,
        icon: demoImageBase64,
        color: Color(0xFF4285F4),
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
          SliverAppBar(
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            pinned: true,
            expandedHeight: 90,
            toolbarHeight: 60,
            actionsPadding: EdgeInsets.symmetric(horizontal: 10),
            actions: [
              IconButton(
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.onSecondary,
                  backgroundColor: AppColors.onPrimary,
                ),
                onPressed: () {
                  context.go(AppRoutes.notifications);
                },
                icon: Icon(Iconsax.notification),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "This Month Spend",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      Text(
                        "\$2,000",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              spacing: 20,
              children: [
                SubscriptionBarChart(
                  subscriptions: subscriptions,
                ),
                Upcomings(),
                AllSubscriptions(),
              ],
            ),
          ),
        ],
      ),
      // Expandable FAB overlay
      Positioned(
        right: 16,
        bottom: 16,
        child: SafeArea(
          child: ListenableBuilder(
            listenable: Listenable.merge([_isFabVisible, _isExpanded]),
            builder: (context, _) {
              return AnimatedSlide(
                offset: _isFabVisible.value
                    ? Offset.zero
                    : const Offset(0, 2),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: AnimatedOpacity(
                  opacity: _isFabVisible.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Expandable options
                      SizeTransition(
                        sizeFactor: _expandAnimation,
                        axisAlignment: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildFabOption(
                                label: 'Category',
                                icon: Iconsax.add,
                                onTap: () {
                                  _toggleExpanded();
                                  context.push(AppRoutes.addCategory);
                                },
                              ),
                              const SizedBox(height: 10),
                              _buildFabOption(
                                label: 'Plans',
                                icon: Iconsax.add,
                                onTap: () {
                                  _toggleExpanded();
                                  context.push(AppRoutes.addPlan);

                                  // TODO: Navigate to add plan
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Main FAB
                      FloatingActionButton(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        shape: const CircleBorder(),
                        onPressed: _toggleExpanded,
                        child: AnimatedRotation(
                          turns: _isExpanded.value ? 0.125 : 0,
                          duration: const Duration(milliseconds: 250),
                          child: const Icon(Iconsax.add),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      ],
    ),
    );
  }

  Widget _buildFabOption({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceLight,
            ),
          ),
        ),
        const SizedBox(width: 10),
        FloatingActionButton.small(
          heroTag: label,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: const CircleBorder(),
          onPressed: onTap,
          child: Icon(icon, size: 20),
        ),
      ],
    );
  }
}
