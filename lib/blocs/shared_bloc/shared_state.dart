part of 'shared_bloc.dart';

abstract class SharedState extends Equatable {
  const SharedState();
}

class SharedInitial extends SharedState {
  @override
  List<Object> get props => [];
}

class LanguageChanged extends SharedState {
  final String loc;
  const LanguageChanged({required this.loc});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
