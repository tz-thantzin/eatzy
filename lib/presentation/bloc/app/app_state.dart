part of 'app_bloc.dart';

enum AppStatus { authenticating, authenticated, unauthenticated }

final class AppState extends Equatable {
  final AppStatus status;
  final User? user;

  AppState({User? user})
    : this._(
        status: user == null || !user.isEmailVerified
            ? AppStatus.unauthenticated
            : AppStatus.authenticated,
        user: user,
      );

  const AppState._({required this.status, this.user});

  AppState authenticating() {
    return AppState._(status: AppStatus.authenticating, user: user);
  }

  @override
  List<Object> get props => <Object>[status, ?user];
}
