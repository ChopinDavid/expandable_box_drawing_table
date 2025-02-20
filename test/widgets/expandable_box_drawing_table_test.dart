import 'dart:async';
import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:expandable_box_drawing_table/bloc/entry_values_bloc.dart';
import 'package:expandable_box_drawing_table/models/section.dart';
import 'package:expandable_box_drawing_table/widgets/expandable_box_drawing_table.dart';
import 'package:expandable_box_drawing_table/widgets/section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks.dart';

main() {
  late EntryValuesBloc<int> entryValuesBloc;

  setUp(() {
    entryValuesBloc = MockEntryValuesBloc<int>();

    whenListen(entryValuesBloc, Stream.fromIterable(<EntryValuesState<int>>[]),
        initialState: EntryValuesUpdated<int>([1]));
  });

  // TODO(DC): I have no idea why this test doesn't complete...
  testWidgets(
    'invokes onValuesChanged when state is EntryValuesUpdated',
    skip: true,
    (widgetTester) async {
      entryValuesBloc = EntryValuesBloc<int>(initialValues: []);

      const expectedNewValues = [1, 2, 3];

      final completer = Completer<void>();
      await widgetTester.pumpWidget(
        MaterialApp(
          home: ExpandableBoxDrawingTable<int>(
            initialValues: [],
            sections: [],
            onValuesChanged: (newValues) {
              expect(newValues, expectedNewValues);
              if (!completer.isCompleted) {
                completer.complete();
              }
            },
            entryValuesBloc: entryValuesBloc,
          ),
        ),
      );

      await widgetTester.pumpAndSettle();

      entryValuesBloc.add(EntryValuesUpdateValuesSelectedEvent<int>(
          expectedNewValues,
          selected: true));

      await widgetTester.pumpAndSettle();
      await completer.future.timeout(const Duration(seconds: 5), onTimeout: () {
        throw TimeoutException('The test timed out');
      });
    },
  );

  testWidgets(
    'renders a SectionWidget for each passed Section',
    (widgetTester) async {
      final expectedSectionCount = Random().nextInt(10) + 1;

      await widgetTester.pumpWidget(
        MaterialApp(
          home: ExpandableBoxDrawingTable<int>(
            initialValues: [],
            sections: List.generate(
              expectedSectionCount,
              (index) => Section<int>(
                title: 'Section $index',
                subSections: [],
              ),
            ),
            entryValuesBloc: entryValuesBloc,
          ),
        ),
      );

      await widgetTester.pumpAndSettle();

      expect(
          find.byType(
            SectionWidget<int>,
          ),
          findsNWidgets(expectedSectionCount));
    },
  );
}
