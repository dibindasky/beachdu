part of 'question_tab_bloc.dart';

@freezed
class QuestionTabEvent with _$QuestionTabEvent {
  const factory QuestionTabEvent.tabChange() = TabChange;
  const factory QuestionTabEvent.resetTabSelection() = ResetTabSelection;
  const factory QuestionTabEvent.getQuestions({
    required String categoryType,
    required Product product,
  }) = GetQuestions;
  const factory QuestionTabEvent.getAnswerCount() = GetAnswerCount;
  const factory QuestionTabEvent.markedQuestions({
    required SelectedOption selectedOption,
  }) = MarkedQuestions;
  const factory QuestionTabEvent.countQuestionNumber(
      {required int countQuestionNumber}) = CountQuestionNumber;
}
