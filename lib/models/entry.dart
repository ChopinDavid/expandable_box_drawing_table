import 'package:equatable/equatable.dart';

class Entry<T> extends Equatable {
  const Entry({required this.title, required this.value});
  final String title;
  final T value;

  @override
  List<Object?> get props => [title, value];
}
