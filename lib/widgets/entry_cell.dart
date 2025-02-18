import 'package:expandable_box_drawing_table/bloc/entry_values_bloc.dart';
import 'package:expandable_box_drawing_table/models/entry.dart';
import 'package:expandable_box_drawing_table/models/expandable_box_drawing_table_configuration.dart';
import 'package:expandable_box_drawing_table/widgets/up_and_right_box_drawing_character_widget.dart';
import 'package:expandable_box_drawing_table/widgets/vertical_and_right_box_drawing_character_widget.dart';
import 'package:expandable_box_drawing_table/widgets/vertical_box_drawing_character_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntryCell<T> extends StatelessWidget {
  const EntryCell({
    super.key,
    required this.entry,
    this.onTap,
    required this.depth,
    required this.isLastExerciseInList,
  });
  final Entry<T> entry;
  final void Function({required bool selected, required T value})? onTap;
  final int depth;
  final bool isLastExerciseInList;

  @override
  Widget build(BuildContext context) {
    final withCheckbox = ExpandableBoxDrawingTableConfiguration.of(context)
        .entriesHaveCheckBoxes;
    return BlocBuilder<EntryValuesBloc<T>, EntryValuesState<T>>(
        builder: (context, state) {
      if (state is EntryValuesUpdated<T>) {
        final row = Row(
          children: [
            Text(entry.title),
            if (withCheckbox) ...[
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: IgnorePointer(
                  child: SizedBox.square(
                    dimension: Checkbox.width,
                    child: Checkbox(
                      value: state.entryValues.contains(entry.value),
                      onChanged: (bool? value) {},
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
        return SizedBox(
          height: 36.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...List.generate(depth, (index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: index == depth - 1
                      ? isLastExerciseInList
                          ? const UpAndRightBoxDrawingCharacterWidget()
                          : const VerticalAndRightBoxDrawingCharacterWidget()
                      : const VerticalBoxDrawingCharacterWidget(),
                );
              }),
              const SizedBox(width: 4.0),
              Expanded(
                child: withCheckbox
                    ? InkWell(
                        child: row,
                        onTap: () {
                          BlocProvider.of<EntryValuesBloc<T>>(context).add(
                              EntryValuesUpdateValuesSelectedEvent(
                                  [entry.value],
                                  selected: !state.entryValues
                                      .contains(entry.value)));
                        },
                      )
                    : row,
              ),
            ],
          ),
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }
}
