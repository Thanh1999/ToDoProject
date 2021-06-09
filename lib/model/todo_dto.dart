class ToDoDTO {
  String title;
  bool isChecked;

  ToDoDTO({required this.title, this.isChecked = false});

  factory ToDoDTO.fromJson(dynamic json) {
    return ToDoDTO(title: json["title"], isChecked: json["isChecked"]);
  }

  Map<String, dynamic> toJson() {
    return {"title": this.title, "isChecked": this.isChecked};
  }
}
