class Item {
  late int _id;
  late String kode;
  late String name;
  late int price;
  late int stok;

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  Item({
      required this.name,
      required this.price,
      required this.stok
  });

  Item.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    name = map['name'];
    price = map['price'];
    stok = map['stok'];
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'stok': stok};
  }
}