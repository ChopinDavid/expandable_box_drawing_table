import 'package:flutter/material.dart';

class ExpandableBoxDrawingTableConfiguration extends InheritedWidget {
  const ExpandableBoxDrawingTableConfiguration({
    super.key,
    required this.configuration,
    required super.child,
  });

  final ExpandableBoxDrawingTableConfigurationData configuration;

  static ExpandableBoxDrawingTableConfigurationData of(BuildContext context) {
    final ExpandableBoxDrawingTableConfiguration? result =
        context.dependOnInheritedWidgetOfExactType<
            ExpandableBoxDrawingTableConfiguration>();
    assert(result != null,
        'No ExpandableBoxDrawingTableConfiguration found in context');
    return result!.configuration;
  }

  @override
  bool updateShouldNotify(ExpandableBoxDrawingTableConfiguration oldWidget) {
    return configuration != oldWidget.configuration;
  }
}

class ExpandableBoxDrawingTableConfigurationData {
  const ExpandableBoxDrawingTableConfigurationData({
    required this.sectionsHaveCheckBoxes,
    required this.entriesHaveCheckBoxes,
    required this.expandedIcon,
    required this.collapsedIcon,
  }) : assert(!(sectionsHaveCheckBoxes && !entriesHaveCheckBoxes),
            'sectionsHaveCheckBoxes cannot be true if entriesHaveCheckBoxes is false');

  final bool sectionsHaveCheckBoxes;
  final bool entriesHaveCheckBoxes;
  final IconData expandedIcon;
  final IconData collapsedIcon;

  const ExpandableBoxDrawingTableConfigurationData.defaultConfiguration()
      : sectionsHaveCheckBoxes = true,
        entriesHaveCheckBoxes = true,
        expandedIcon = Icons.arrow_drop_down,
        collapsedIcon = Icons.arrow_right;

  ExpandableBoxDrawingTableConfigurationData copyWith({
    bool? sectionsHaveCheckBoxes,
    bool? entriesHaveCheckBoxes,
    IconData? expandedIcon,
    IconData? collapsedIcon,
  }) {
    return ExpandableBoxDrawingTableConfigurationData(
      sectionsHaveCheckBoxes:
          sectionsHaveCheckBoxes ?? this.sectionsHaveCheckBoxes,
      entriesHaveCheckBoxes:
          entriesHaveCheckBoxes ?? this.entriesHaveCheckBoxes,
      expandedIcon: expandedIcon ?? this.expandedIcon,
      collapsedIcon: collapsedIcon ?? this.collapsedIcon,
    );
  }
}
