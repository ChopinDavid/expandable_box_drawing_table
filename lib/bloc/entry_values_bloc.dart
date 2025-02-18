import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'entry_values_event.dart';
part 'entry_values_state.dart';

class EntryValuesBloc<T>
    extends Bloc<EntryValuesEvent<T>, EntryValuesState<T>> {
  EntryValuesBloc({required List<T> initialValues})
      : _entryValues = initialValues,
        super(EntryValuesUpdated<T>(initialValues)) {
    on<EntryValuesUpdateValuesSelectedEvent<T>>((event, emit) {
      for (var entryValue in event.entryValues) {
        if (_entryValues.contains(entryValue) && !event.selected) {
          _entryValues.remove(entryValue);
        } else if (!_entryValues.contains(entryValue) && event.selected) {
          _entryValues.add(entryValue);
        }
      }
      emit(EntryValuesUpdated(_entryValues));
    });
  }

  List<T> _entryValues;
}
