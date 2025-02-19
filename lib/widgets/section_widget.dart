import 'package:expandable_box_drawing_table/bloc/entry_values_bloc.dart';
import 'package:expandable_box_drawing_table/models/expandable_box_drawing_table_configuration.dart';
import 'package:expandable_box_drawing_table/models/section.dart';
import 'package:expandable_box_drawing_table/widgets/entry_cell.dart';
import 'package:expandable_box_drawing_table/widgets/up_and_right_box_drawing_character_widget.dart';
import 'package:expandable_box_drawing_table/widgets/vertical_and_right_box_drawing_character_widget.dart';
import 'package:expandable_box_drawing_table/widgets/vertical_box_drawing_character_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionWidget<T> extends StatefulWidget {
  const SectionWidget({
    super.key,
    required this.section,
    this.depth = 0,
    required this.isLastSubSection,
  });
  final Section<T> section;
  final int depth;
  final bool isLastSubSection;

  @override
  State<SectionWidget<T>> createState() => _SectionWidgetState<T>();
}

class _SectionWidgetState<T> extends State<SectionWidget<T>> {
  final ExpansionTileController controller = ExpansionTileController();
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final subSections = widget.section.subSections;
    final entries = widget.section.entries;
    return BlocBuilder<EntryValuesBloc<T>, EntryValuesState<T>>(
        builder: (context, state) {
      if (state is EntryValuesUpdated<T>) {
        return ExpansionTile(
          onExpansionChanged: (value) {
            setState(() {
              isExpanded = value;
            });
          },
          trailing: ExpandableBoxDrawingTableConfiguration.of(context)
                  .sectionsHaveCheckBoxes
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Checkbox(
                    value: widget.section.subSectionsEnabled(
                      enabledValues: state.entryValues,
                    ),
                    tristate: true,
                    onChanged: (isChecked) {
                      context.read<EntryValuesBloc<T>>().add(
                            EntryValuesUpdateValuesSelectedEvent<T>(
                              widget.section
                                  .flattenEntries()
                                  .map(
                                    (e) => e.value,
                                  )
                                  .toList(),
                              selected: isChecked == true,
                            ),
                          );
                    },
                  ),
                )
              : const SizedBox.shrink(),
          controller: controller,
          collapsedShape: LinearBorder.none,
          shape: LinearBorder.none,
          minTileHeight: 0,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          tilePadding: EdgeInsets.zero,
          title: Container(
            height: 36.0,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(),
            child: Row(
              children: [
                ...List.generate(
                  widget.depth,
                  (index) => Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: index == widget.depth - 1
                        ? widget.isLastSubSection && !isExpanded
                            ? const UpAndRightBoxDrawingCharacterWidget()
                            : const VerticalAndRightBoxDrawingCharacterWidget()
                        : const VerticalBoxDrawingCharacterWidget(),
                  ),
                ),
                const SizedBox(width: 4.0),
                Text(widget.section.title),
                Icon(
                  !isExpanded
                      ? ExpandableBoxDrawingTableConfiguration.of(context)
                          .collapsedIcon
                      : ExpandableBoxDrawingTableConfiguration.of(context)
                          .expandedIcon,
                ),
              ],
            ),
          ),
          children: (subSections != null)
              ? subSections
                  .map(
                    (e) => SectionWidget<T>(
                      section: e,
                      depth: widget.depth + 1,
                      isLastSubSection:
                          subSections.indexOf(e) == subSections.length - 1,
                    ),
                  )
                  .toList()
              : entries!.map((entry) {
                  return EntryCell<T>(
                    entry: entry,
                    depth: widget.depth + 1,
                    isLastExerciseInList:
                        entries.indexOf(entry) == entries.length - 1,
                  );
                }).toList(),
        );
      } else {
        return const SizedBox.shrink(key: Key('empty-state'));
      }
    });
  }
}
