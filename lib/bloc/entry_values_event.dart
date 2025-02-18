part of 'entry_values_bloc.dart';

@immutable
sealed class EntryValuesEvent<T> {}

class EntryValuesUpdateValuesSelectedEvent<T> extends EntryValuesEvent<T> {
  EntryValuesUpdateValuesSelectedEvent(
    this.entryValues, {
    required this.selected,
  });
  final List<T> entryValues;
  final bool selected;
}
