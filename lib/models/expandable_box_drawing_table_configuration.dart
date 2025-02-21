import 'package:equatable/equatable.dart';
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

class ExpandableBoxDrawingTableConfigurationData extends Equatable {
  const ExpandableBoxDrawingTableConfigurationData({
    required this.sectionsHaveCheckBoxes,
    required this.entriesHaveCheckBoxes,
    required this.expandedIcon,
    required this.collapsedIcon,
    required this.expandedIconColor,
    required this.collapsedIconColor,
  }) : assert(!(sectionsHaveCheckBoxes && !entriesHaveCheckBoxes),
            'sectionsHaveCheckBoxes cannot be true if entriesHaveCheckBoxes is false');

  final bool sectionsHaveCheckBoxes;
  final bool entriesHaveCheckBoxes;
  final IconData expandedIcon;
  final IconData collapsedIcon;
  final Color? expandedIconColor;
  final Color? collapsedIconColor;

  const ExpandableBoxDrawingTableConfigurationData.defaultConfiguration()
      : sectionsHaveCheckBoxes = true,
        entriesHaveCheckBoxes = true,
        expandedIcon = Icons.arrow_drop_down,
        collapsedIcon = Icons.arrow_right,
        expandedIconColor = null,
        collapsedIconColor = null;

  ExpandableBoxDrawingTableConfigurationData copyWith({
    bool? sectionsHaveCheckBoxes,
    bool? entriesHaveCheckBoxes,
    IconData? expandedIcon,
    IconData? collapsedIcon,
    Color? expandedIconColor,
    Color? collapsedIconColor,
  }) {
    return ExpandableBoxDrawingTableConfigurationData(
      sectionsHaveCheckBoxes:
          sectionsHaveCheckBoxes ?? this.sectionsHaveCheckBoxes,
      entriesHaveCheckBoxes:
          entriesHaveCheckBoxes ?? this.entriesHaveCheckBoxes,
      expandedIcon: expandedIcon ?? this.expandedIcon,
      collapsedIcon: collapsedIcon ?? this.collapsedIcon,
      expandedIconColor: expandedIconColor,
      collapsedIconColor: collapsedIconColor,
    );
  }

  @override
  List<Object?> get props => [
        sectionsHaveCheckBoxes,
        entriesHaveCheckBoxes,
        expandedIcon,
        collapsedIcon,
        expandedIconColor,
        collapsedIconColor,
      ];
}
