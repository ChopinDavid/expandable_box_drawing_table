part of 'entry_values_bloc.dart';

@immutable
sealed class EntryValuesState<T> extends Equatable {}

final class EntryValuesUpdated<T> extends EntryValuesState<T> {
  EntryValuesUpdated(this.entryValues);
  final List<T> entryValues;

  @override
  List<Object?> get props => [entryValues];
}
