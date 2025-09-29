part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class UserSubscriptionRequested extends AppEvent {
  const UserSubscriptionRequested();
}

final class UserProfileAdded extends AppEvent {
  const UserProfileAdded();
}

final class OnboardingCompleted extends AppEvent {
  const OnboardingCompleted();
}

final class LogoutPressed extends AppEvent {
  const LogoutPressed();
}
