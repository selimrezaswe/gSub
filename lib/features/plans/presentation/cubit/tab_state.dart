import 'package:equatable/equatable.dart';
import 'package:subscription_manager/features/plans/presentation/cubit/tab_cubit.dart';

class TabState extends Equatable {
  final PlanTab selectedTab;

  const TabState({required this.selectedTab});

  @override
  List<Object?> get props => [selectedTab];

  TabState copyWith({PlanTab? selectedTab}) {
    return TabState(selectedTab: selectedTab ?? this.selectedTab);
  }
}