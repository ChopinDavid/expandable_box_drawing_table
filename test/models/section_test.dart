import 'package:expandable_box_drawing_table/models/entry.dart';
import 'package:expandable_box_drawing_table/models/section.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group(
    'assertions',
    () {
      test('asserts that the section cannot have both subSections and entries',
          () {
        expect(
          () => Section<String>(
            title: 'title',
            subSections: [],
            entries: [],
          ),
          throwsAssertionError,
        );
      });

      test('asserts that the section must have either subSections or entries',
          () {
        expect(
          () => Section<String>(
            title: 'title',
          ),
          throwsAssertionError,
        );
      });
    },
  );

  group(
    'flattenEntries',
    () {
      test('returns entries when there are no subSections', () {
        final section = Section<String>(
          title: 'title',
          entries: [
            Entry(
              title: 'entry1',
              value: 'entry1',
            ),
            Entry(title: 'entry2', value: 'entry2'),
          ],
        );
        expect(section.flattenEntries(), [
          Entry(title: 'entry1', value: 'entry1'),
          Entry(title: 'entry2', value: 'entry2'),
        ]);
      });

      test('returns entries and subSection entries when there are subSections',
          () {
        final section = Section<String>(
          title: 'title',
          subSections: [
            Section<String>(
              title: 'subSection1',
              entries: [
                Entry(title: 'entry1', value: 'entry1'),
              ],
            ),
            Section<String>(
              title: 'subSection2',
              entries: [
                Entry(title: 'entry2', value: 'entry2'),
              ],
            ),
            Section<String>(title: 'subSection3', subSections: [
              Section<String>(
                title: 'subSection3.1',
                entries: [
                  Entry(title: 'entry3.1', value: 'entry3.1'),
                ],
              ),
            ]),
          ],
        );
        expect(section.flattenEntries(), [
          Entry(title: 'entry1', value: 'entry1'),
          Entry(title: 'entry2', value: 'entry2'),
          Entry(title: 'entry3.1', value: 'entry3.1'),
        ]);
      });
    },
  );

  group(
    'subSectionsEnabled',
    () {
      test('returns false when no enabled values are present', () {
        final section = Section<String>(
          title: 'title',
          entries: [
            Entry(title: 'entry1', value: 'entry1'),
            Entry(title: 'entry2', value: 'entry2'),
          ],
        );
        expect(section.subSectionsEnabled(enabledValues: []), false);
      });

      test('returns true when all values are enabled', () {
        final section = Section<String>(
          title: 'title',
          entries: [
            Entry(title: 'entry1', value: 'entry1'),
            Entry(title: 'entry2', value: 'entry2'),
          ],
        );
        expect(
          section.subSectionsEnabled(enabledValues: ['entry1', 'entry2']),
          true,
        );
      });

      test(
          'returns true all values are enabled, even in distantly descendant subSections',
          () {
        final section = Section<String>(
          title: 'title',
          subSections: [
            Section(
              title: 'Section1',
              subSections: [
                Section(
                  title: 'Section1.1',
                  subSections: [
                    Section(
                      title: 'Section1.1.1',
                      entries: [
                        Entry(
                          title: 'entry1.1.1',
                          value: 'entry1.1.1',
                        ),
                      ],
                    ),
                    Section(
                      title: 'Section1.1.2',
                      entries: [
                        Entry(
                          title: 'entry1.1.2',
                          value: 'entry1.1.2',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
        expect(
          section
              .subSectionsEnabled(enabledValues: ['entry1.1.1', 'entry1.1.2']),
          true,
        );
      });

      test('returns null when some values are enabled', () {
        final section = Section<String>(
          title: 'title',
          entries: [
            Entry(title: 'entry1', value: 'entry1'),
            Entry(title: 'entry2', value: 'entry2'),
          ],
        );
        expect(
          section.subSectionsEnabled(enabledValues: ['entry1']),
          null,
        );
      });

      test(
          'returns null when some values are enabled, even in distantly descendant subSections',
          () {
        final section = Section<String>(
          title: 'title',
          subSections: [
            Section(
              title: 'Section1',
              subSections: [
                Section(
                  title: 'Section1.1',
                  subSections: [
                    Section(
                      title: 'Section1.1.1',
                      entries: [
                        Entry(
                          title: 'entry1.1.1',
                          value: 'entry1.1.1',
                        ),
                      ],
                    ),
                    Section(
                      title: 'Section1.1.2',
                      entries: [
                        Entry(
                          title: 'entry1.1.2',
                          value: 'entry1.1.2',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
        expect(
          section.subSectionsEnabled(enabledValues: ['entry1.1.1']),
          null,
        );
      });
    },
  );
}
