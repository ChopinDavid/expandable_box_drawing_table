import 'package:bloc_test/bloc_test.dart';
import 'package:expandable_box_drawing_table/bloc/entry_values_bloc.dart';
import 'package:expandable_box_drawing_table/models/section.dart';
import 'package:mocktail/mocktail.dart';

class MockEntryValuesBloc<T>
    extends MockBloc<EntryValuesEvent<T>, EntryValuesState<T>>
    implements EntryValuesBloc<T> {}

class MockSection<T> extends Mock implements Section<T> {
  MockSection() {
    when(() => title).thenReturn('some title');
  }
}
