class Currency {
   var GUID;
  final String Name;

   Currency({
     this.GUID,
     this.Name,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      GUID: json['GUID'] as String,
      Name: json['Name'] as String,

    );
  }
}
