import 'package:bloc_test/bloc_test.dart';
import 'package:expandable_box_drawing_table/bloc/entry_values_bloc.dart';
import 'package:expandable_box_drawing_table/models/entry.dart';
import 'package:expandable_box_drawing_table/models/expandable_box_drawing_table_configuration.dart';
import 'package:expandable_box_drawing_table/widgets/entry_cell.dart';
import 'package:expandable_box_drawing_table/widgets/up_and_right_box_drawing_character_widget.dart';
import 'package:expandable_box_drawing_table/widgets/vertical_and_right_box_drawing_character_widget.dart';
import 'package:expandable_box_drawing_table/widgets/vertical_box_drawing_character_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

main() {
  late EntryValuesBloc<int> mockEntryValuesBloc;

  setUp(() {
    mockEntryValuesBloc = MockEntryValuesBloc<int>();
    whenListen(
      mockEntryValuesBloc,
      Stream.fromIterable(<EntryValuesState<int>>[]),
      initialState: EntryValuesUpdated<int>([1]),
    );
  });

  group('when state is EntryValuesUpdated', () {
    testWidgets(
      'shows title',
      (widgetTester) async {
        const expectedTitle = 'some title';
        await widgetTester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpandableBoxDrawingTableConfiguration(
                configuration: ExpandableBoxDrawingTableConfigurationData
                    .defaultConfiguration(),
                child: BlocProvider<EntryValuesBloc<int>>.value(
                  value: mockEntryValuesBloc,
                  child: EntryCell<int>(
                    entry: Entry<int>(title: expectedTitle, value: 1),
                    depth: 0,
                    isLastExerciseInList: true,
                  ),
                ),
              ),
            ),
          ),
        );
        await widgetTester.pump();
        await widgetTester.idle();

        expect(find.text(expectedTitle), findsOneWidget);
      },
    );

    testWidgets(
      'returns row',
      (widgetTester) async {
        await widgetTester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpandableBoxDrawingTableConfiguration(
                configuration: ExpandableBoxDrawingTableConfigurationData
                    .defaultConfiguration(),
                child: BlocProvider<EntryValuesBloc<int>>.value(
                  value: mockEntryValuesBloc,
                  child: EntryCell<int>(
                    entry: Entry<int>(title: 'title', value: 1),
                    depth: 0,
                    isLastExerciseInList: true,
                  ),
                ),
              ),
            ),
          ),
        );
        await widgetTester.pump();
        await widgetTester.idle();

        expect(find.byKey(const Key('row')), findsOneWidget);
        expect(find.byKey(const Key('empty-state')), findsNothing);
      },
    );

    testWidgets(
      "shows Checkbox if configuration's entriesHaveCheckBoxes is true",
      (widgetTester) async {
        await widgetTester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpandableBoxDrawingTableConfiguration(
                configuration: ExpandableBoxDrawingTableConfigurationData
                        .defaultConfiguration()
                    .copyWith(entriesHaveCheckBoxes: true),
                child: BlocProvider<EntryValuesBloc<int>>.value(
                  value: mockEntryValuesBloc,
                  child: EntryCell<int>(
                    entry: Entry<int>(title: 'title', value: 1),
                    depth: 0,
                    isLastExerciseInList: true,
                  ),
                ),
              ),
            ),
          ),
        );
        await widgetTester.pump();
        await widgetTester.idle();

        expect(find.byType(Checkbox), findsOneWidget);
      },
    );

    testWidgets(
      "does not show Checkbox if configuration's entriesHaveCheckBoxes is false",
      (widgetTester) async {
        await widgetTester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpandableBoxDrawingTableConfiguration(
                configuration: ExpandableBoxDrawingTableConfigurationData
                        .defaultConfiguration()
                    .copyWith(
                        sectionsHaveCheckBoxes: false,
                        entriesHaveCheckBoxes: false),
                child: BlocProvider<EntryValuesBloc<int>>.value(
                  value: mockEntryValuesBloc,
                  child: EntryCell<int>(
                    entry: Entry<int>(title: 'title', value: 1),
                    depth: 0,
                    isLastExerciseInList: false,
                  ),
                ),
              ),
            ),
          ),
        );
        await widgetTester.pump();
        await widgetTester.idle();

        expect(find.byType(Checkbox), findsNothing);
      },
    );

    testWidgets(
      'displays depth - 1 VerticalBoxDrawingCharacterWidget and one UpAndRightBoxDrawingCharacterWidget when isLastExerciseInList is true',
      (widgetTester) async {
        const depth = 8;
        await widgetTester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpandableBoxDrawingTableConfiguration(
                configuration: ExpandableBoxDrawingTableConfigurationData
                        .defaultConfiguration()
                    .copyWith(entriesHaveCheckBoxes: true),
                child: BlocProvider<EntryValuesBloc<int>>.value(
                  value: mockEntryValuesBloc,
                  child: EntryCell<int>(
                    entry: Entry<int>(title: 'title', value: 1),
                    depth: depth,
                    isLastExerciseInList: true,
                  ),
                ),
              ),
            ),
          ),
        );
        await widgetTester.pumpAndSettle();

        expect(find.byType(VerticalBoxDrawingCharacterWidget),
            findsNWidgets(depth - 1));
        expect(
            find.byType(UpAndRightBoxDrawingCharacterWidget), findsOneWidget);
        expect(find.byType(VerticalAndRightBoxDrawingCharacterWidget),
            findsNothing);
      },
    );

    testWidgets(
      'displays depth - 1 VerticalBoxDrawingCharacterWidget and one VerticalAndRightBoxDrawingCharacterWidget when isLastExerciseInList is false',
      (widgetTester) async {
        const depth = 8;
        await widgetTester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpandableBoxDrawingTableConfiguration(
                configuration: ExpandableBoxDrawingTableConfigurationData
                        .defaultConfiguration()
                    .copyWith(entriesHaveCheckBoxes: true),
                child: BlocProvider<EntryValuesBloc<int>>.value(
                  value: mockEntryValuesBloc,
                  child: EntryCell<int>(
                    entry: Entry<int>(title: 'title', value: 1),
                    depth: depth,
                    isLastExerciseInList: false,
                  ),
                ),
              ),
            ),
          ),
        );
        await widgetTester.pumpAndSettle();

        expect(find.byType(VerticalBoxDrawingCharacterWidget),
            findsNWidgets(depth - 1));
        expect(find.byType(UpAndRightBoxDrawingCharacterWidget), findsNothing);
        expect(find.byType(VerticalAndRightBoxDrawingCharacterWidget),
            findsOneWidget);
      },
    );

    testWidgets(
      "invokes EntryValuesBloc.add(EntryValuesUpdateValuesSelectedEvent) with selected false when InkWell is tapped when configuration's entriesHaveCheckBoxes is true and entry value is in state",
      (widgetTester) async {
        final entry = Entry<int>(title: 'title', value: 1);
        await widgetTester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpandableBoxDrawingTableConfiguration(
                configuration: ExpandableBoxDrawingTableConfigurationData
                        .defaultConfiguration()
                    .copyWith(entriesHaveCheckBoxes: true),
                child: BlocProvider<EntryValuesBloc<int>>.value(
                  value: mockEntryValuesBloc,
                  child: EntryCell<int>(
                    entry: entry,
                    depth: 0,
                    isLastExerciseInList: true,
                  ),
                ),
              ),
            ),
          ),
        );
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byType(InkWell));
        await widgetTester.pumpAndSettle();

        verify(() => mockEntryValuesBloc.add(
            EntryValuesUpdateValuesSelectedEvent([entry.value],
                selected: false)));
      },
    );

    testWidgets(
      "invokes EntryValuesBloc.add(EntryValuesUpdateValuesSelectedEvent) with selected true when InkWell is tapped when configuration's entriesHaveCheckBoxes is true and entry value is not in state",
      (widgetTester) async {
        final entry = Entry<int>(title: 'title', value: 100);
        await widgetTester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpandableBoxDrawingTableConfiguration(
                configuration: ExpandableBoxDrawingTableConfigurationData
                        .defaultConfiguration()
                    .copyWith(entriesHaveCheckBoxes: true),
                child: BlocProvider<EntryValuesBloc<int>>.value(
                  value: mockEntryValuesBloc,
                  child: EntryCell<int>(
                    entry: entry,
                    depth: 0,
                    isLastExerciseInList: true,
                  ),
                ),
              ),
            ),
          ),
        );
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byType(InkWell));
        await widgetTester.pumpAndSettle();

        verify(() => mockEntryValuesBloc.add(
            EntryValuesUpdateValuesSelectedEvent([entry.value],
                selected: true)));
      },
    );

    testWidgets(
      "does not have an InkWell when configuration's entriesHaveCheckBoxes is false",
      (widgetTester) async {
        const entry = Entry<int>(title: 'title', value: 1);
        await widgetTester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpandableBoxDrawingTableConfiguration(
                configuration: ExpandableBoxDrawingTableConfigurationData
                        .defaultConfiguration()
                    .copyWith(
                        sectionsHaveCheckBoxes: false,
                        entriesHaveCheckBoxes: false),
                child: BlocProvider<EntryValuesBloc<int>>.value(
                  value: mockEntryValuesBloc,
                  child: EntryCell<int>(
                    entry: entry,
                    depth: 0,
                    isLastExerciseInList: false,
                  ),
                ),
              ),
            ),
          ),
        );
        await widgetTester.pumpAndSettle();

        expect(find.byType(InkWell), findsNothing);
      },
    );
  });

  group('when state is not EntryValuesUpdated', () {
    testWidgets(
      'returns empty state widget',
      (widgetTester) async {
        whenListen(
            mockEntryValuesBloc, Stream.fromIterable(<EntryValuesState<int>>[]),
            initialState: _DifferentEntryValuesState<int>());

        await widgetTester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExpandableBoxDrawingTableConfiguration(
                configuration: ExpandableBoxDrawingTableConfigurationData
                    .defaultConfiguration(),
                child: BlocProvider<EntryValuesBloc<int>>.value(
                  value: mockEntryValuesBloc,
                  child: EntryCell<int>(
                    entry: Entry<int>(title: 'title', value: 1),
                    depth: 0,
                    isLastExerciseInList: true,
                  ),
                ),
              ),
            ),
          ),
        );
        await widgetTester.pump();
        await widgetTester.idle();

        expect(find.byKey(const Key('row')), findsNothing);
        expect(find.byKey(const Key('empty-state')), findsOneWidget);
      },
    );
  });
}

class _DifferentEntryValuesState<T> extends EntryValuesState<T> {
  _DifferentEntryValuesState() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}
