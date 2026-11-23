class ActivityModel {
  final String id;
  final String name;
  final int counter;

  const ActivityModel({
    required this.id,
    required this.name,
    this.counter = 0,
  });

  ActivityModel copyWith({String? name, int? counter}) {
    return ActivityModel(
      id: id,
      name: name ?? this.name,
      counter: counter ?? this.counter,
    );
  }
}
