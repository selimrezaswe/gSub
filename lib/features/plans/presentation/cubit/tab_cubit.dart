import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_manager/features/plans/presentation/cubit/tab_state.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(const TabState(selectedTab: PlanTab.active));

  void setSelectedTab(PlanTab selectedTab) {
    emit(state.copyWith(selectedTab: selectedTab));
  }
}




enum PlanTab {
  active,
  upcoming,
  trial,
  unsubscribed;

  String get name => switch (this) {
    active => "Active",
    upcoming => "Upcoming",
    trial => "Trial",
    unsubscribed => "Unsubscribed",
  };
}