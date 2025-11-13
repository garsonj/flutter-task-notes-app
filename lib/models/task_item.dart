class TaskItem {
  int? id;
  String title;
  int priority;
  String description;
  bool isCompleted;

  TaskItem({
    this.id,
    required this.title,
    this.priority = 1,
    this.description = '',
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'priority': priority,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory TaskItem.fromJson(Map<String, dynamic> json) {
    return TaskItem(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}'),
      title: json['title'] as String? ?? '',
      priority: (json['priority'] as num?)?.toInt() ?? 1,
      description: json['description'] as String? ?? '',
      isCompleted: (json['isCompleted'] is int
              ? (json['isCompleted'] as int) == 1
              : (json['isCompleted'] == true)),
    );
  }

  TaskItem copyWith({
    int? id,
    String? title,
    int? priority,
    String? description,
    bool? isCompleted,
  }) {
    return TaskItem(
      id: id ?? this.id,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
