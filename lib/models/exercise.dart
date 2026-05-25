class Exercise {
  final int? id;
  final String name;
  final int series;
  final int repetitions;
  final String? observations;

  Exercise({
    this.id,
    required this.name,
    required this.series,
    required this.repetitions,
    this.observations,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'series': series,
      'repetitions': repetitions,
      'observations': observations,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'] as int?,
      name: map['name'] as String,
      series: map['series'] as int,
      repetitions: map['repetitions'] as int,
      observations: map['observations'] as String?,
    );
  }

  Exercise copyWith({
    int? id,
    String? name,
    int? series,
    int? repetitions,
    String? observations,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      series: series ?? this.series,
      repetitions: repetitions ?? this.repetitions,
      observations: observations ?? this.observations,
    );
  }
}
