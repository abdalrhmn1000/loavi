part of 'shared_bloc.dart';

abstract class SharedEvent extends Equatable {
  const SharedEvent();
}

class ChangedLanguage extends SharedEvent {
  final String loc;
  const ChangedLanguage({required this.loc});
  @override
  // TODO: implement props
  List<Object?> get props => [loc];

}
