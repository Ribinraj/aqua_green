part of 'fetch_profile_bloc.dart';

@immutable
sealed class FetchProfileEvent {}
final class FetchProfileInitailEvent extends FetchProfileEvent{}