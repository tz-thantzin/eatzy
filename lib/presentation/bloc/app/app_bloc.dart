import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user.dart';
import '../../domain/usecases/auth_usecase.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthUseCase _authUseCase;

  AppBloc({required AuthUseCase authUseCase})
    : _authUseCase = authUseCase,
      super(AppState()) {
    on<UserSubscriptionRequested>(_onUserSubscriptionRequested);
    on<UserProfileAdded>(_onUserProfileAdded);
    on<LogoutPressed>(_onLogoutPressed);
  }

  Future<void> _onUserSubscriptionRequested(
    UserSubscriptionRequested event,
    Emitter<AppState> emit,
  ) {
    emit(state.authenticating());
    return emit.onEach(
      _authUseCase.user,
      onData: (User? user) async {
        if (user == null) {
          return emit(AppState(user: user));
        }

        User userProfile = await _authUseCase.getUserProfile(
          uid: user.uid,
          email: user.email!,
        );

        emit(AppState(user: userProfile));
      },
      onError: addError,
    );
  }

  Future<void> _onUserProfileAdded(
    UserProfileAdded event,
    Emitter<AppState> emit,
  ) async {
    final User? user = state.user;

    User? userProfile;
    if (user != null && user.email != null) {
      userProfile = await _authUseCase.getUserProfile(
        uid: user.uid,
        email: user.email!,
      );
    }

    emit(AppState(user: userProfile?.copyWith(isUserProfileExist: true)));
  }

  Future<void> _onLogoutPressed(
    LogoutPressed event,
    Emitter<AppState> emit,
  ) async {
    await _authUseCase.logout();
  }
}
