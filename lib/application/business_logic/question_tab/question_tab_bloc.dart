import 'package:beachdu/application/presentation/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'question_tab_event.dart';
part 'question_tab_state.dart';
part 'question_tab_bloc.freezed.dart';

class QuestionTabBloc extends Bloc<QuestionTabEvent, QuestionTabState> {
  QuestionTabBloc() : super(QuestionTabState.initial()) {
    on<_TabChange>((event, emit) {
      if (state.selectedTabIndex >= state.tabItems.length - 1) {
        print(
            'state.selectedTabIndex >= state.tabItems.length - 1 ${state.selectedTabIndex}');
        return emit(state.copyWith(selectedTabIndex: 0));
      } else {
        emit(state.copyWith(
          selectedTabIndex: state.selectedTabIndex + 1,
          // message: 'Saved in Database',
        ));
      }
      // if (state.selectedTabIndex < state.tabItems.length - 1) {
      //   print('_TabChange bloc ${state.selectedTabIndex}');
      // }
    });
  }
}
