part of 'network_bloc.dart';

@immutable
sealed class NetworkEvent {}

class GetData extends NetworkEvent {}