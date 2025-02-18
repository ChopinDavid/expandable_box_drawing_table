import 'package:expandable_box_drawing_table/bloc/entry_values_bloc.dart';
import 'package:expandable_box_drawing_table/models/expandable_box_drawing_table_configuration.dart';
import 'package:expandable_box_drawing_table/models/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'section_widget.dart';

class ExpandableBoxDrawingTable<T> extends StatelessWidget {
  const ExpandableBoxDrawingTable({
    super.key,
    required this.initialValues,
    this.configuration =
        const ExpandableBoxDrawingTableConfigurationData.defaultConfiguration(),
    required this.sections,
    this.onValuesChanged,
  });
  final List<T> initialValues;
  final ExpandableBoxDrawingTableConfigurationData configuration;
  final List<Section<T>> sections;
  final void Function(List<T>)? onValuesChanged;

  @override
  Widget build(BuildContext context) {
    return ExpandableBoxDrawingTableConfiguration(
      configuration: configuration,
      child: BlocProvider<EntryValuesBloc<T>>(
        create: (context) => EntryValuesBloc(initialValues: initialValues),
        child: BlocListener<EntryValuesBloc<T>, EntryValuesState<T>>(
          listener: (context, state) {
            if (state is EntryValuesUpdated<T>) {
              onValuesChanged?.call(state.entryValues);
            }
          },
          child: Theme(
            data: Theme.of(context).copyWith(
              listTileTheme: const ListTileThemeData(minVerticalPadding: 0.0),
            ),
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: sections.length,
              itemBuilder: (context, index) {
                final section = sections[index];
                return SectionWidget<T>(
                  section: section,
                  isLastSubSection: index == sections.length - 1,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
