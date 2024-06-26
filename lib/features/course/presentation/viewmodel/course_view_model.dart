import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/common/my_snackbar.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/course/domain/usecases/course_usecase.dart';
import 'package:student_management_starter/features/course/presentation/state/course_state.dart';

final courseViewModelProvider =
    StateNotifierProvider<CourseViewModel, CourseState>((ref) {
  return CourseViewModel(ref.read(courseUseCaseProvider));
});

class CourseViewModel extends StateNotifier<CourseState> {
  CourseViewModel(this.courseUseCase) : super(CourseState.initial()) {
    getAllCourses();
  }
  final CourseUseCase courseUseCase;

  addCourse(CourseEntity course) async {
    state = state.copyWith(isLoading: true);
    var data = await courseUseCase.addCourse(course);
    data.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
      showMySnackBar(message: l.error, color: Colors.red[800]);
    }, (r) {
      state = state.copyWith(isLoading: false, error: null);
      showMySnackBar(message: "course Added Sucessfully!");
    });
    getAllCourses();
  }

  getAllCourses() async {
    state = state.copyWith(isLoading: true);
    var data = await courseUseCase.getAllCourses();
    data.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
      showMySnackBar(message: l.error, color: Colors.red[800]);
    }, (r) {
      state = state.copyWith(isLoading: false, lst: r, error: null);
    });
  }
}
