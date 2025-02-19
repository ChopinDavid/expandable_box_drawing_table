import 'package:bloc_test/bloc_test.dart';
import 'package:expandable_box_drawing_table/bloc/entry_values_bloc.dart';

class MockEntryValuesBloc<T>
    extends MockBloc<EntryValuesEvent<T>, EntryValuesState<T>>
    implements EntryValuesBloc<T> {}
