part of 'entry_values_bloc.dart';

@immutable
sealed class EntryValuesEvent<T> extends Equatable {}

class EntryValuesUpdateValuesSelectedEvent<T> extends EntryValuesEvent<T> {
  EntryValuesUpdateValuesSelectedEvent(
    this.entryValues, {
    required this.selected,
  });
  final List<T> entryValues;
  final bool selected;

  @override
  List<Object?> get props => [entryValues, selected];
}
