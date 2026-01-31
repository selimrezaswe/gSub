import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_manager/features/app_bottom_nav/presentation/cubit/app_bottom_nav_state.dart';

class AppBottomNavCubit extends Cubit<AppBottomNavState> {
  AppBottomNavCubit() : super(const AppBottomNavState(selectedIndex: 1));

  void changeIndex(int index) {
    if (index != state.selectedIndex) {
      emit(AppBottomNavState(selectedIndex: index));
    }
  }
}
