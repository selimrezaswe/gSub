import 'package:equatable/equatable.dart';

class AppBottomNavState extends Equatable {
  final int selectedIndex;

  const AppBottomNavState({required this.selectedIndex});

  @override
  List<Object?> get props => [selectedIndex];
}
