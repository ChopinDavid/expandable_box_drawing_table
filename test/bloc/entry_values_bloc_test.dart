import 'package:bloc_test/bloc_test.dart';
import 'package:expandable_box_drawing_table/bloc/entry_values_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late EntryValuesBloc testObject;

  setUp(() {
    testObject = EntryValuesBloc<String>(initialValues: ['a', 'b', 'c']);
  });

  test(
    'EntryValuesUpdated is initial state with passed initialValues',
    () {
      const expectedInitialValues = ['d', 'e', 'f'];
      final testObject =
          EntryValuesBloc<String>(initialValues: expectedInitialValues);
      expect(
          testObject.state, EntryValuesUpdated<String>(expectedInitialValues));
    },
  );

  blocTest(
    "removes every passed value that exists in Bloc's _entryValues when event.selected is false",
    build: () => testObject,
    act: (bloc) => bloc.add(
      EntryValuesUpdateValuesSelectedEvent<String>(
        ['a', 'c'],
        selected: false,
      ),
    ),
    expect: () => [
      EntryValuesUpdated<String>(['b'])
    ],
  );

  blocTest(
    "does not remove any passed value that exists in Bloc's _entryValues when event.selected is true",
    build: () => testObject,
    act: (bloc) => bloc.add(
      EntryValuesUpdateValuesSelectedEvent<String>(
        ['a', 'c'],
        selected: true,
      ),
    ),
    expect: () => [
      EntryValuesUpdated<String>(['a', 'b', 'c'])
    ],
  );

  blocTest(
    "adds every passed value that does not exist in Bloc's _entryValues when event.selected is true",
    setUp: () => testObject = EntryValuesBloc<String>(initialValues: []),
    build: () => testObject,
    act: (bloc) => bloc.add(
      EntryValuesUpdateValuesSelectedEvent<String>(
        ['d', 'e', 'f'],
        selected: true,
      ),
    ),
    expect: () => [
      EntryValuesUpdated<String>(['d', 'e', 'f'])
    ],
  );

  blocTest(
    "does not add every passed value that does not in Bloc's _entryValues when event.selected is false",
    setUp: () => testObject = EntryValuesBloc<String>(initialValues: []),
    build: () => testObject,
    act: (bloc) => bloc.add(
      EntryValuesUpdateValuesSelectedEvent<String>(
        ['d', 'e', 'f'],
        selected: false,
      ),
    ),
    expect: () => [EntryValuesUpdated<String>([])],
  );
}
