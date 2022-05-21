class Salary {
  String no;
  String image;
  double salary;
  double hour;
  String type;
  double paid;
  String name;
  
  Salary({
    required this.no,
    required this.image,
    required this.salary,
    required this.hour,
    required this.type,
    required this.paid,
    required this.name,
  });

  Map<String, dynamic> get values {
    return {
      'no': no,
      'name': name,
      'image': image,
      'salary': salary,
      'hour': hour,
      'type': type,
      'paid': paid,
      
    };
  }
}
