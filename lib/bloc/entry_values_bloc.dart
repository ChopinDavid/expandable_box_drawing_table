import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'entry_values_event.dart';
part 'entry_values_state.dart';

class EntryValuesBloc<T>
    extends Bloc<EntryValuesEvent<T>, EntryValuesState<T>> {
  EntryValuesBloc({required List<T> initialValues})
      : _entryValues = initialValues,
        super(EntryValuesUpdated<T>(initialValues)) {
    on<EntryValuesUpdateValuesSelectedEvent<T>>((event, emit) {
      var newEntryValues = List.of(_entryValues);
      for (var entryValue in event.entryValues) {
        if (newEntryValues.contains(entryValue) && !event.selected) {
          newEntryValues.remove(entryValue);
        } else if (!newEntryValues.contains(entryValue) && event.selected) {
          newEntryValues.add(entryValue);
        }
      }
      _entryValues = newEntryValues;
      emit(EntryValuesUpdated(_entryValues));
    });
  }

  List<T> _entryValues;
}
