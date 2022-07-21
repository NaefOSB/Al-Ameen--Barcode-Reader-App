class Product {
  String Name;
  String Group_Name;
  String Currency;
  String Unity;
  String Unit2;
  String Unit3;
  double Price1;
  double Price2;
  double Price3;
  double Unit2Fact;
  double Unit3Fact;
  String Picture;
  int SearchedKind;

  Product(
      this.Name,
      this.Group_Name,
      this.Currency,
      this.Unity,
      this.Unit2,
      this.Unit3,
      this.Price1,
      this.Price2,
      this.Price3,
      this.Unit2Fact,
      this.Unit3Fact,
      this.Picture,
      this.SearchedKind);

  factory Product.fromJson(dynamic json) {
    return Product(
        json['Name'] as String,
        json['Group_Name'] as String,
        json['Currency'] as String,
        json['Unity'] as String,
        json['Unit2'] as String,
        json['Unit3'] as String,
        json['Price1'] as double,
        json['Price2'] as double,
        json['Price3'] as double,
        json['Unit2Fact'] as double,
        json['Unit3Fact'] as double,
        json['Picture'] as String,
      json['SearchedKind'] as int
    );

  }

  @override
  String toString() {
    return '{ ${this.Name}, ${this.Group_Name},${this.Currency}, ${this.Price1},${this.Price2},${this.Price3}, }';
  }
}
