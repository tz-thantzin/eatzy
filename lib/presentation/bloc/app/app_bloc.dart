import 'package:eatzy/domain/usecases/shared_preference_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/user.dart';
import '../../../domain/usecases/auth_usecase.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthUseCase _authUseCase;
  final SharedPreferenceUseCase _sharedPreferenceUseCase;

  AppBloc({
    required AuthUseCase authUseCase,
    required SharedPreferenceUseCase sharePreferenceUseCase,
  }) : _authUseCase = authUseCase,
       _sharedPreferenceUseCase = sharePreferenceUseCase,
       super(AppState()) {
    on<UserSubscriptionRequested>(_onUserSubscriptionRequested);
    on<UserProfileAdded>(_onUserProfileAdded);
    on<OnboardingCompleted>(_onboardingCompleted);
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
        final isOnboardingCompleted = await _sharedPreferenceUseCase
            .isOnboardingCompleted();

        if (user == null) {
          // User not logged in → isOnboardingCompleted -> ? unauthenticated : firstLaunch
          return emit(
            AppState._(
              status: isOnboardingCompleted
                  ? AppStatus.unauthenticated
                  : AppStatus.firstLaunch,
              user: null,
            ),
          );
        }

        User userProfile = await _authUseCase.getUserProfile(
          uid: user.uid,
          email: user.email!,
        );

        if (!isOnboardingCompleted) {
          // User exists but onboarding not completed
          return emit(AppState(user: userProfile).onboardingNotCompleted());
        }

        emit(AppState(user: userProfile));
      },
      onError: addError,
    );
  }

  Future<void> _onboardingCompleted(
    OnboardingCompleted event,
    Emitter<AppState> emit,
  ) async {
    print("_onboardingCompleted");
    await _sharedPreferenceUseCase.setOnboardingCompleted(true);
    emit(AppState._(status: AppStatus.unauthenticated));
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
