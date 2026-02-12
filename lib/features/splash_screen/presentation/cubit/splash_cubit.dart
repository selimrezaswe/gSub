import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_manager/features/splash_screen/presentation/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial()) {
    startDelay();
  }

  void startDelay() {
    Future.delayed(const Duration(seconds: 2), () {
      emit(const SplashNavigateToOnboarding());
    });
  }
}
