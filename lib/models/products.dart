class Product {
  final int id;
  final double amountHoney;
  final double? amountPropolis;
  final double? amountWax;
  final double? amountRoyalJelly;

  const Product({
    required this.id,
    required this.amountHoney,
    this.amountPropolis,
    this.amountWax,
    this.amountRoyalJelly,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'honey': amountHoney,
      'propolis': amountPropolis,
      'wax': amountWax,
      'royal_jelly': amountRoyalJelly,
    };
  }

  // Converte um Map em um objeto Specie
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      amountHoney: map['amount_honey'],
      amountPropolis: map['amount_propolis'],
      amountWax: map['amount_wax'],
      amountRoyalJelly: map['amount_royal_jelly'],
    );
  }
}
