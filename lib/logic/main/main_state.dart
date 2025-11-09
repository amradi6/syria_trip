part of 'main_cubit.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

final class BalanceLoading extends MainState{}

final class BalanceSuccess extends MainState{
  final double balance;
  BalanceSuccess(this.balance);
}

final class BalanceError extends MainState{
  final String message;
  BalanceError(this.message);
}

final class CompanyLoading extends MainState{}

final class CompanySuccess extends MainState{
  final List<dynamic> companies;
  CompanySuccess(this.companies);
}

final class CompanyError extends MainState{
  final String message;
  CompanyError(this.message);
}

final class MainFromChanged extends MainState{
  final String from;
  MainFromChanged(this.from);
}

final class MainToChanged extends MainState{
  final String to;
  MainToChanged(this.to);
}

final class CompanyRouteLoading extends MainState{}

final class CompanyRouteSuccess extends MainState{
  final Map<String, dynamic> routes;
  CompanyRouteSuccess(this.routes);
}

final class CompanyRouteError extends MainState{
  final String message;
  CompanyRouteError(this.message);
}

final class SeatsLoading extends MainState{}

final class SeatsSuccess extends MainState{
  final List<dynamic> seats;
  SeatsSuccess(this.seats);
}

final class SeatsError extends MainState{
  final String message;
  SeatsError(this.message);
}