/* Define a task representation. */
class Task {
  /* Define the types of each instance value. */
  int? id;
  String? title;
  DateTime? created;
  bool? isChecked;

  /* Define the constructor. */
  Task({
    this.id,
    this.title,
    this.created,
    this.isChecked,
  });
}