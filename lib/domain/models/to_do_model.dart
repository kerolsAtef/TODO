class Todo {
  final String id;
  final String title;
  final String time;
   int isChecked;
  Todo({
    required this.id,
    required this.title,
    required this.time,
    required this.isChecked
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'isChecked':isChecked
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      time: map['time'],
        isChecked:map['isChecked']
    );
  }
  Todo copyWith({required String id,required String title,required int isChecked, required String time}) {
    return Todo(
      id:  this.id,
      title:  this.title,
      isChecked: this.isChecked,
      time: this.time,
    );
  }
}
