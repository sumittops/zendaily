
enum RecurrenceType {
  weekly,
  daily,
  monthly
} 

class Task {
  final String title;
  final String category;
  final RecurrenceType recurrenceType;


  Task({
    this.title,
    this.category,
    this.recurrenceType
  });

}