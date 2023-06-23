class Patient {
  late int id;
  String name;
  String description; 
  int age;
  int kg;
  int size;

  Patient.withId(this.id , this.name , this.description , this.age , this.kg, this.size);
  Patient (this.name , this.description , this.age , this.kg, this.size);
}
