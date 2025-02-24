
# expandable_box_drawing_table

<p align="center">
<a href="https://github.com/ChopinDavid/expandable_box_drawing_table/actions"><img src="https://github.com/ChopinDavid/expandable_box_drawing_table/actions/workflows/test.yml/badge.svg" alt="build"></a>
<a href="https://app.codecov.io/gh/ChopinDavid/expandable_box_drawing_table"><img src="https://codecov.io/gh/ChopinDavid/expandable_box_drawing_table/branch/main/graph/badge.svg" alt="codecov"></a>
<a href="https://pub.dev/packages/expandable_box_drawing_table"><img src="https://img.shields.io/pub/v/expandable_box_drawing_table.svg" alt="pub package"></a>
</p>

`expandable_box_drawing_table` provides a Flutter widget called `ExpandableBoxDrawingTable`. This widget allows users to create a table with expandable sections, where each section can contain multiple subsections. The widget uses <a href="https://en.wikipedia.org/wiki/Box-drawing_characters" target="_blank">box drawing characters</a> to visually represent the structure and hierarchy of the table, making it easier for developers to create and manage complex, nested layouts. Both entries and sections can be checked. When entries are checked, the updated list of selected values can be handled in a callback. Checking sections will either select or unselect all descendent sections and entries, providing a comprehensive way to manage hierarchical data.

<p align="center">
  <img src="https://github.com/user-attachments/assets/cf6f29f7-d2f9-4e0a-93fc-6752db340604" height="500" width="434"/>
</p>


https://github.com/user-attachments/assets/fe695c98-a254-42d5-950d-1705bcdbaab2


## Features

* Recursively display hierarchical data in easy-to-understand tables
* Add callbacks to handle when data changes
* Provide a custom configuration for more control over table appearance and behavior

## Usage

***For working examples, please refer to the `example` project included in this repository***
#### Definitions
As the usage of this package is explained, you will encounter some words that have specific meanings within the context of using this package:
- `value`: A `value` is any piece of data. They are associated with an `Entry` that will appear at the lowest-level of a hierarchy. Your `ExpandableBoxDrawingTable` is generic and can be passed a type. This type determines the type of the `List` of newly-selected `value`s returned when any data in your table changes.
- `Entry`: An `Entry` appears at the lowest-level of a hierarchy in `ExpandableBoxDrawingTable`. They contain an associated `value` that can be handled when their associated `EntryCell` is "selected" (via tapping its `Checkbox`).
- `Section`: `Section`s are classes that contain either a list of more `Section`s (`Section.subSections`) or a list of `Entry`s (`Section.entries`), but not both. There can be any number of recursively nested `subSections` within a `Section`. All `Section` hierarchies will, in theory, end with a list of `Entry`s (can be an empty list) to be displayed to the user.
#### Basic Setup
Creating your Expandable Box Drawing Table is as simple as creating an `ExpandableBoxDrawingTable` with `initialValues` and `Sections`:
```dart
ExpandableBoxDrawingTable<String>( 
  initialValues:  
    sharedPreferences.getStringList('selected_values') ?? [],
  sections: [
    Section<String>(
      title: '1',
      entries: [
        Entry<String>(title: '1', value: '1.1'),
        Entry<String>(title: '2', value: '1.2'),
      ],
    ),
    Section<String>(
      title: '2',
      entries: [
        Entry<String>(title: '1', value: '2.1'),
        Entry<String>(title: '2', value: '2.2'),
      ],
    ),
  ],
);
```
<p align="center">
  <img src="https://github.com/user-attachments/assets/f6dd6216-42e2-494f-afbb-d682a0b0b4c0" height="500" width="230"/>
</p>

Let's assume that, in the above example, `sharedPreferences.getStringList('selected_values')` returned `['1.2', '2.1']`. In this case, the `EntryCell`s associated with the `Entry`s with these `'1.1'` and `'2.1'` `value`s would be initially "selected", i.e. their checkbox will initially be checked.

#### Handling selected data
This interface would be mostly useless if we didn't provide a means of handling newly-selected data. Luckily, `ExpandableBoxDrawingTable` comes with an `onValuesChanged` callback so that you can handle changes to selected data:
```dart
ExpandableBoxDrawingTable<String>( 
  initialValues:  
    sharedPreferences.getStringList('selected_values') ?? [],
  onValuesChanged: (newValues) {
    sharedPreferences.setStringList('selected_values', newValues);
  },
  ...
);
```

You'll notice that `ExpandableBoxDrawingTable` is generic. This is done in order to avoid needing to type cast handled data. For this reason, whichever `value`s are provided to `initialValues` must be a `List<T>` , where `T` is the same type passed to `ExpandableBoxDrawingTable<T>`. You could omit typing `ExpandableBoxDrawingTable`, but any new `value`s handled in `onValuesChanged` would likely end up needing to be type casted at some point.

#### Customization
The appearance and behavior of your `ExpandableBoxDrawingTable` can be customized to fit your specific needs. This is done through the use of `ExpandableBoxDrawingTableConfigurationData`:
```dart
ExpandableBoxDrawingTable(  
  configuration: 
    ExpandableBoxDrawingTableConfigurationData(  
      sectionsHaveCheckBoxes: false,  
      entriesHaveCheckBoxes: false,  
      expandedIcon: Icons.catching_pokemon,  
      collapsedIcon: Icons.bubble_chart_outlined,  
    ),
  ...
);
```
<p align="center">
  <img src="https://github.com/user-attachments/assets/666771fa-ea22-465e-a7e8-b396fe711465" height="500" width="230"/>
</p>

This configuration data class currently only supports very basic configuration, i.e. whether `Section`s and `Entry`s should display `Checkbox`es, or which `IconData` to use for icons on expanded or collapsed sections. In theory, this class could be expanded to support a much broader range of configuration options, such as paddings, indentation, colors, custom box drawing "characters", and adding "builders" to allow sections to only display their `Checkbox`es if certain criteria are met (such as how "deep" the `Section` is within the main `Section`).

## Additional information

Feel free to file issues and/or make pull requests if you have any bug reports/feature requests! PRs that are written without test coverage will not be merged until adequate coverage is added (either by the requester or a maintainer).
