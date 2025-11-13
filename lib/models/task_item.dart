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

 
}
