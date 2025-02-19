import 'package:expandable_box_drawing_table/models/expandable_box_drawing_table_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('ExpandableBoxDrawingTableConfiguration', () {
    testWidgets(
      'of method returns the ExpandableBoxDrawingTableConfigurationData of nearest ancestor ExpandableBoxDrawingTableConfiguration',
      (widgetTester) async {
        const expectedExpandableBoxDrawingTableConfigurationData =
            ExpandableBoxDrawingTableConfigurationData(
          sectionsHaveCheckBoxes: false,
          entriesHaveCheckBoxes: false,
          expandedIcon: Icons.catching_pokemon,
          collapsedIcon: Icons.bubble_chart_outlined,
        );

        ExpandableBoxDrawingTableConfigurationData? actualConfigurationData;

        await widgetTester.pumpWidget(
          ExpandableBoxDrawingTableConfiguration(
            configuration: expectedExpandableBoxDrawingTableConfigurationData,
            child: Builder(
              builder: (context) {
                actualConfigurationData =
                    ExpandableBoxDrawingTableConfiguration.of(context);
                return SizedBox.shrink();
              },
            ),
          ),
        );
        await widgetTester.pumpAndSettle();

        expect(actualConfigurationData,
            expectedExpandableBoxDrawingTableConfigurationData);
      },
    );
  });

  group('ExpandableBoxDrawingTableConfigurationData', () {
    test(
      'default constructor creates an instance with the provided values',
      () {
        const expectedExpandableBoxDrawingTableConfigurationData =
            ExpandableBoxDrawingTableConfigurationData(
          sectionsHaveCheckBoxes: false,
          entriesHaveCheckBoxes: false,
          expandedIcon: Icons.catching_pokemon,
          collapsedIcon: Icons.bubble_chart_outlined,
        );

        expect(
          expectedExpandableBoxDrawingTableConfigurationData
              .sectionsHaveCheckBoxes,
          false,
        );
        expect(
          expectedExpandableBoxDrawingTableConfigurationData
              .entriesHaveCheckBoxes,
          false,
        );
        expect(
          expectedExpandableBoxDrawingTableConfigurationData.expandedIcon,
          Icons.catching_pokemon,
        );
        expect(
          expectedExpandableBoxDrawingTableConfigurationData.collapsedIcon,
          Icons.bubble_chart_outlined,
        );
      },
    );

    test(
      'defaultConfiguration constructor creates an instance with the default values',
      () {
        const expectedExpandableBoxDrawingTableConfigurationData =
            ExpandableBoxDrawingTableConfigurationData.defaultConfiguration();

        expect(
          expectedExpandableBoxDrawingTableConfigurationData
              .sectionsHaveCheckBoxes,
          true,
        );
        expect(
          expectedExpandableBoxDrawingTableConfigurationData
              .entriesHaveCheckBoxes,
          true,
        );
        expect(
          expectedExpandableBoxDrawingTableConfigurationData.expandedIcon,
          Icons.arrow_drop_down,
        );
        expect(
          expectedExpandableBoxDrawingTableConfigurationData.collapsedIcon,
          Icons.arrow_right,
        );
      },
    );

    test(
      'copyWith method returns a new instance with the provided values',
      () {
        const expectedExpandableBoxDrawingTableConfigurationData =
            ExpandableBoxDrawingTableConfigurationData(
          sectionsHaveCheckBoxes: false,
          entriesHaveCheckBoxes: false,
          expandedIcon: Icons.catching_pokemon,
          collapsedIcon: Icons.bubble_chart_outlined,
        );

        final actualExpandableBoxDrawingTableConfigurationData =
            ExpandableBoxDrawingTableConfigurationData.defaultConfiguration()
                .copyWith(
          sectionsHaveCheckBoxes: false,
          entriesHaveCheckBoxes: false,
          expandedIcon: Icons.catching_pokemon,
          collapsedIcon: Icons.bubble_chart_outlined,
        );

        expect(
          actualExpandableBoxDrawingTableConfigurationData,
          expectedExpandableBoxDrawingTableConfigurationData,
        );
      },
    );
  });
}
