import 'package:equatable/equatable.dart';
import 'package:expandable_box_drawing_table/models/entry.dart';

class Section<T> extends Equatable {
  const Section({required this.title, this.subSections, this.entries})
      : assert(
          subSections == null || entries == null,
          'Section cannot have both subSections and entries',
        ),
        assert(
          subSections != null || entries != null,
          'Section must have either subSections or entries',
        );
  final String title;
  final List<Section<T>>? subSections;
  final List<Entry<T>>? entries;

  List<Entry<T>> flattenEntries() {
    final entries = this.entries;
    final subSections = this.subSections;
    return [
      if (entries != null) ...entries,
      if (subSections != null)
        ...subSections.expand((subSection) => subSection.flattenEntries()),
    ];
  }

  bool? subSectionsEnabled({required List<T> enabledValues}) {
    final flattenedEntries = flattenEntries();
    final flattenedEntriesValues =
        flattenedEntries.map((e) => e.value).toList();
    final enabledEntriesValues = enabledValues
        .where((element) => flattenedEntriesValues.contains(element))
        .toList();
    return enabledEntriesValues.isEmpty
        ? false
        : enabledEntriesValues.length == flattenedEntriesValues.length
            ? true
            : null;
  }

  @override
  List<Object?> get props => [title, subSections, entries];
}
