import 'package:bloc_test/bloc_test.dart';
import 'package:expandable_box_drawing_table/bloc/entry_values_bloc.dart';
import 'package:expandable_box_drawing_table/models/entry.dart';
import 'package:expandable_box_drawing_table/models/expandable_box_drawing_table_configuration.dart';
import 'package:expandable_box_drawing_table/models/section.dart';
import 'package:expandable_box_drawing_table/widgets/entry_cell.dart';
import 'package:expandable_box_drawing_table/widgets/section_widget.dart';
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
      'shows ExpansionTile with title of section',
      (widgetTester) async {
        const expectedTitle = 'some title';

        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: ExpandableBoxDrawingTableConfigurationData
                .defaultConfiguration(),
            child: MaterialApp(
              home: BlocProvider<EntryValuesBloc<int>>.value(
                value: mockEntryValuesBloc,
                child: Scaffold(
                  body: SectionWidget<int>(
                    section: Section<int>(
                      title: expectedTitle,
                      subSections: [],
                    ),
                    isLastSubSection: false,
                  ),
                ),
              ),
            ),
          ),
        );

        await widgetTester.pumpAndSettle();

        expect(find.text(expectedTitle), findsOneWidget);
        expect(find.byType(ExpansionTile), findsOneWidget);
        expect(find.byKey(const Key('empty-state')), findsNothing);
      },
    );

    testWidgets(
      "shows configuration's collapsed icon when ExpansionTile is collapsed",
      (widgetTester) async {
        const expectedCollapsedIcon = Icons.catching_pokemon;
        const expectedCollapsedIconColor = Colors.red;

        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: ExpandableBoxDrawingTableConfigurationData
                    .defaultConfiguration()
                .copyWith(
                    collapsedIcon: expectedCollapsedIcon,
                    collapsedIconColor: expectedCollapsedIconColor),
            child: MaterialApp(
              home: BlocProvider<EntryValuesBloc<int>>.value(
                value: mockEntryValuesBloc,
                child: Scaffold(
                  body: SectionWidget<int>(
                    section: Section<int>(
                      title: 'title',
                      subSections: [],
                    ),
                    isLastSubSection: false,
                  ),
                ),
              ),
            ),
          ),
        );

        await widgetTester.pumpAndSettle();

        final iconFinder = find.byIcon(expectedCollapsedIcon);
        expect(iconFinder, findsOneWidget);
        expect(widgetTester.widget<Icon>(iconFinder).color,
            expectedCollapsedIconColor);
      },
    );

    testWidgets(
      "shows configuration's expanded icon when ExpansionTile is expanded",
      (widgetTester) async {
        const expectedExpandedIcon = Icons.bubble_chart_outlined;
        const expectedExpandedIconColor = Colors.lightBlue;

        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: ExpandableBoxDrawingTableConfigurationData
                    .defaultConfiguration()
                .copyWith(
              expandedIcon: expectedExpandedIcon,
              expandedIconColor: expectedExpandedIconColor,
            ),
            child: MaterialApp(
              home: BlocProvider<EntryValuesBloc<int>>.value(
                value: mockEntryValuesBloc,
                child: Scaffold(
                  body: SectionWidget<int>(
                    section: Section<int>(
                      title: 'title',
                      subSections: [],
                    ),
                    isLastSubSection: false,
                  ),
                ),
              ),
            ),
          ),
        );

        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byType(ExpansionTile));
        await widgetTester.pumpAndSettle();

        final iconFinder = find.byIcon(expectedExpandedIcon);
        expect(iconFinder, findsOneWidget);
        expect(widgetTester.widget<Icon>(iconFinder).color,
            expectedExpandedIconColor);
      },
    );

    testWidgets(
      'displays depth - 1 VerticalBoxDrawingCharacterWidgets and one UpAndRightBoxDrawingCharacterWidget when isLastSubSection and controller is not expanded',
      (widgetTester) async {
        const depth = 8;

        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: ExpandableBoxDrawingTableConfigurationData
                .defaultConfiguration(),
            child: MaterialApp(
              home: BlocProvider<EntryValuesBloc<int>>.value(
                value: mockEntryValuesBloc,
                child: Scaffold(
                  body: SectionWidget(
                    section: Section<int>(
                      title: 'title',
                      subSections: [],
                    ),
                    isLastSubSection: true,
                    depth: depth,
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
      'displays depth - 1 VerticalBoxDrawingCharacterWidgets and one VerticalAndRightBoxDrawingCharacterWidget when isLastSubSection and controller is expanded',
      (widgetTester) async {
        const depth = 8;

        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: ExpandableBoxDrawingTableConfigurationData
                .defaultConfiguration(),
            child: MaterialApp(
              home: BlocProvider<EntryValuesBloc<int>>.value(
                value: mockEntryValuesBloc,
                child: Scaffold(
                  body: SectionWidget(
                    section: Section<int>(
                      title: 'title',
                      subSections: [],
                    ),
                    isLastSubSection: true,
                    depth: depth,
                  ),
                ),
              ),
            ),
          ),
        );
        await widgetTester.pumpAndSettle();

        await widgetTester.tap(find.byType(ExpansionTile));
        await widgetTester.pumpAndSettle();

        expect(find.byType(VerticalBoxDrawingCharacterWidget),
            findsNWidgets(depth - 1));
        expect(find.byType(UpAndRightBoxDrawingCharacterWidget), findsNothing);
        expect(find.byType(VerticalAndRightBoxDrawingCharacterWidget),
            findsOneWidget);
      },
    );

    testWidgets(
      'displays depth - 1 VerticalBoxDrawingCharacterWidgets and one VerticalAndRightBoxDrawingCharacterWidget when isLastSubSection is false and controller is not expanded',
      (widgetTester) async {
        const depth = 8;

        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: ExpandableBoxDrawingTableConfigurationData
                .defaultConfiguration(),
            child: MaterialApp(
              home: BlocProvider<EntryValuesBloc<int>>.value(
                value: mockEntryValuesBloc,
                child: Scaffold(
                  body: SectionWidget(
                    section: Section<int>(
                      title: 'title',
                      subSections: [],
                    ),
                    isLastSubSection: false,
                    depth: depth,
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
      'maps all subSections to SectionWidgets with correct depth and isLastSubSection values when subSections is not null',
      (widgetTester) async {
        const originalDepth = 3;
        final subSections = List.generate(
          8,
          (index) => Section<int>(
            title: '$index',
            entries: [],
          ),
        );

        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: ExpandableBoxDrawingTableConfigurationData
                .defaultConfiguration(),
            child: MaterialApp(
              home: BlocProvider<EntryValuesBloc<int>>.value(
                value: mockEntryValuesBloc,
                child: Scaffold(
                  body: SectionWidget(
                    section: Section<int>(
                      title: 'title',
                      subSections: subSections,
                    ),
                    isLastSubSection: false,
                    depth: originalDepth,
                  ),
                ),
              ),
            ),
          ),
        );
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.byType(ExpansionTile));
        await widgetTester.pumpAndSettle();

        expect(find.byType(SectionWidget<int>),
            findsNWidgets(subSections.length + 1));
        for (var i = 0; i < subSections.length; i++) {
          final sectionWidgetFinder = find.byWidgetPredicate((widget) =>
              widget is SectionWidget<int> && widget.section == subSections[i]);
          expect(sectionWidgetFinder, findsOneWidget);
          expect(
              widgetTester
                  .widget<SectionWidget<int>>(sectionWidgetFinder)
                  .depth,
              originalDepth + 1);
          expect(
              widgetTester
                  .widget<SectionWidget<int>>(sectionWidgetFinder)
                  .isLastSubSection,
              i == subSections.length - 1);
        }
      },
    );

    testWidgets(
      'maps all exercises to ExerciseCells with correct depth and isLastExerciseInList values when exercises is not null',
      (widgetTester) async {
        const originalDepth = 3;
        final entries = List.generate(
          8,
          (index) => Entry<int>(title: '$index', value: index),
        );

        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: ExpandableBoxDrawingTableConfigurationData
                .defaultConfiguration(),
            child: MaterialApp(
              home: BlocProvider<EntryValuesBloc<int>>.value(
                value: mockEntryValuesBloc,
                child: Scaffold(
                  body: SectionWidget(
                    section: Section<int>(
                      title: 'title',
                      entries: entries,
                    ),
                    isLastSubSection: false,
                    depth: originalDepth,
                  ),
                ),
              ),
            ),
          ),
        );
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.byType(ExpansionTile));
        await widgetTester.pumpAndSettle();

        expect(find.byType(EntryCell<int>), findsNWidgets(entries.length));
        for (var i = 0; i < entries.length; i++) {
          final exerciseCellFinder = find.byWidgetPredicate((widget) =>
              widget is EntryCell<int> && widget.entry == entries[i]);
          expect(exerciseCellFinder, findsOneWidget);
          expect(widgetTester.widget<EntryCell<int>>(exerciseCellFinder).depth,
              originalDepth + 1);
          expect(
              widgetTester
                  .widget<EntryCell<int>>(exerciseCellFinder)
                  .isLastExerciseInList,
              i == entries.length - 1);
        }
      },
    );

    testWidgets(
      "shows Checkbox when configuration's sectionsHaveCheckBoxes is true",
      (widgetTester) async {
        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: ExpandableBoxDrawingTableConfigurationData
                    .defaultConfiguration()
                .copyWith(sectionsHaveCheckBoxes: true),
            child: MaterialApp(
              home: BlocProvider<EntryValuesBloc<int>>.value(
                value: mockEntryValuesBloc,
                child: Scaffold(
                  body: SectionWidget<int>(
                    section: Section<int>(
                      title: 'title',
                      subSections: [],
                    ),
                    isLastSubSection: false,
                  ),
                ),
              ),
            ),
          ),
        );

        await widgetTester.pumpAndSettle();

        expect(find.byType(Checkbox), findsOneWidget);
      },
    );

    for (var expectedBool in <bool?>[null, true, false]) {
      testWidgets(
        "Checkbox.value is $expectedBool when Section.subSectionsEnabled returns $expectedBool",
        (widgetTester) async {
          final mockSection = MockSection<int>();
          when(() => mockSection.entries).thenReturn([]);
          when(() => mockSection.subSectionsEnabled(
                  enabledValues: any(named: 'enabledValues')))
              .thenReturn(expectedBool);
          await widgetTester.pumpWidget(
            ExpandableBoxDrawingTableConfiguration(
              configuration: ExpandableBoxDrawingTableConfigurationData
                      .defaultConfiguration()
                  .copyWith(sectionsHaveCheckBoxes: true),
              child: MaterialApp(
                home: BlocProvider<EntryValuesBloc<int>>.value(
                  value: mockEntryValuesBloc,
                  child: Scaffold(
                    body: SectionWidget<int>(
                      section: mockSection,
                      isLastSubSection: false,
                    ),
                  ),
                ),
              ),
            ),
          );

          await widgetTester.pumpAndSettle();

          expect(widgetTester.widget<Checkbox>(find.byType(Checkbox)).value,
              expectedBool);
        },
      );
    }

    testWidgets(
      "EntryValuesBloc.add(EntryValueUpdateValuesSelectedEvent) is called with correct values when section.subSectionsEnabled returns null and Checkbox is tapped",
      (widgetTester) async {
        final mockSection = MockSection<int>();
        var expectedFlattenedEntries = List.generate(
          8,
          (index) => Entry<int>(title: '$index', value: index),
        );
        when(() => mockSection.flattenEntries())
            .thenReturn(expectedFlattenedEntries);
        when(() => mockSection.entries).thenReturn([]);
        when(() => mockSection.subSectionsEnabled(
            enabledValues: any(named: 'enabledValues'))).thenReturn(null);

        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: ExpandableBoxDrawingTableConfigurationData
                    .defaultConfiguration()
                .copyWith(sectionsHaveCheckBoxes: true),
            child: MaterialApp(
              home: BlocProvider<EntryValuesBloc<int>>.value(
                value: mockEntryValuesBloc,
                child: Scaffold(
                  body: SectionWidget<int>(
                    section: mockSection,
                    isLastSubSection: false,
                  ),
                ),
              ),
            ),
          ),
        );

        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.byType(Checkbox));
        await widgetTester.pumpAndSettle();

        verify(
          () => mockEntryValuesBloc.add(
            EntryValuesUpdateValuesSelectedEvent<int>(
              expectedFlattenedEntries.map((e) => e.value).toList(),
              selected: false,
            ),
          ),
        ).called(1);
      },
    );

    testWidgets(
      "EntryValuesBloc.add(EntryValueUpdateValuesSelectedEvent) is called with correct values when section.subSectionsEnabled returns true and Checkbox is tapped",
      (widgetTester) async {
        final mockSection = MockSection<int>();
        var expectedFlattenedEntries = List.generate(
          8,
          (index) => Entry<int>(title: '$index', value: index),
        );
        when(() => mockSection.flattenEntries())
            .thenReturn(expectedFlattenedEntries);
        when(() => mockSection.entries).thenReturn([]);
        when(() => mockSection.subSectionsEnabled(
            enabledValues: any(named: 'enabledValues'))).thenReturn(true);

        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: ExpandableBoxDrawingTableConfigurationData
                    .defaultConfiguration()
                .copyWith(sectionsHaveCheckBoxes: true),
            child: MaterialApp(
              home: BlocProvider<EntryValuesBloc<int>>.value(
                value: mockEntryValuesBloc,
                child: Scaffold(
                  body: SectionWidget<int>(
                    section: mockSection,
                    isLastSubSection: false,
                  ),
                ),
              ),
            ),
          ),
        );

        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.byType(Checkbox));
        await widgetTester.pumpAndSettle();

        verify(
          () => mockEntryValuesBloc.add(
            EntryValuesUpdateValuesSelectedEvent<int>(
              expectedFlattenedEntries.map((e) => e.value).toList(),
              selected: false,
            ),
          ),
        ).called(1);
      },
    );

    testWidgets(
      "EntryValuesBloc.add(EntryValueUpdateValuesSelectedEvent) is called with correct values when section.subSectionsEnabled returns false and Checkbox is tapped",
      (widgetTester) async {
        final mockSection = MockSection<int>();
        var expectedFlattenedEntries = List.generate(
          8,
          (index) => Entry<int>(title: '$index', value: index),
        );
        when(() => mockSection.flattenEntries())
            .thenReturn(expectedFlattenedEntries);
        when(() => mockSection.entries).thenReturn([]);
        when(() => mockSection.subSectionsEnabled(
            enabledValues: any(named: 'enabledValues'))).thenReturn(false);

        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: ExpandableBoxDrawingTableConfigurationData
                    .defaultConfiguration()
                .copyWith(sectionsHaveCheckBoxes: true),
            child: MaterialApp(
              home: BlocProvider<EntryValuesBloc<int>>.value(
                value: mockEntryValuesBloc,
                child: Scaffold(
                  body: SectionWidget<int>(
                    section: mockSection,
                    isLastSubSection: false,
                  ),
                ),
              ),
            ),
          ),
        );

        await widgetTester.pumpAndSettle();
        await widgetTester.tap(find.byType(Checkbox));
        await widgetTester.pumpAndSettle();

        verify(
          () => mockEntryValuesBloc.add(
            EntryValuesUpdateValuesSelectedEvent<int>(
              expectedFlattenedEntries.map((e) => e.value).toList(),
              selected: true,
            ),
          ),
        ).called(1);
      },
    );

    testWidgets(
      "does not show Checkbox when configuration's sectionsHaveCheckBoxes is false",
      (widgetTester) async {
        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: ExpandableBoxDrawingTableConfigurationData
                    .defaultConfiguration()
                .copyWith(sectionsHaveCheckBoxes: false),
            child: MaterialApp(
              home: BlocProvider<EntryValuesBloc<int>>.value(
                value: mockEntryValuesBloc,
                child: Scaffold(
                  body: SectionWidget<int>(
                    section: Section<int>(
                      title: 'title',
                      subSections: [],
                    ),
                    isLastSubSection: false,
                  ),
                ),
              ),
            ),
          ),
        );

        await widgetTester.pumpAndSettle();

        expect(find.byType(Checkbox), findsNothing);
      },
    );
  });

  group('when state is not EntryValuesUpdated', () {
    testWidgets(
      'throws exception',
      (widgetTester) async {
        whenListen(
            mockEntryValuesBloc, Stream.fromIterable(<EntryValuesState<int>>[]),
            initialState: _DifferentEntryValuesState<int>());

        await widgetTester.pumpWidget(
          MaterialApp(
            home: BlocProvider<EntryValuesBloc<int>>.value(
              value: mockEntryValuesBloc,
              child: Scaffold(
                body: SectionWidget<int>(
                  section: Section<int>(
                    title: 'title',
                    subSections: [],
                  ),
                  isLastSubSection: false,
                ),
              ),
            ),
          ),
        );

        await widgetTester.pumpAndSettle();

        expect(find.byType(ExpansionTile), findsNothing);
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
