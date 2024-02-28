part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required bool isLoading,
    required bool hasError,
    String? message,
    LoginResponceModel? loginResponceModel,
    required bool logOrNot,
    String? number,
  }) = _Initial;
  factory AuthState.initail() => const AuthState(
        isLoading: false,
        hasError: false,
        logOrNot: false,
      );
}
