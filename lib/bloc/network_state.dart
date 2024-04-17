part of 'network_bloc.dart';

@immutable
sealed class NetworkState {}

final class NetworkInitial extends NetworkState {}

class DataFetched extends NetworkState {
  final String bounds;
  final String legs;

  DataFetched({required this.bounds, required this.legs});
}

class Loading extends NetworkState {}

class Error extends NetworkState {}

