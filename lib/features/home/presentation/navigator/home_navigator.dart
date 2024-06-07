import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/app/navigator/navigator.dart';
import 'package:student_management_starter/features/home/presentation/view/home_view.dart';

final homeViewNavigatorProvider = Provider((ref) => HomeNavigator());

class HomeNavigator {}

mixin HomeViewRoute {
  openDashboardView() {
    NavigateRoute.pushRoute(const HomeView());
  }
}
