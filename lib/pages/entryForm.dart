import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../helpers/dbhelpers.dart';

import '../models/item.dart';

class EntryForm extends StatefulWidget {
  const EntryForm({
    Key? key,
    this.item,
  }) : super(key: key);

  final Item? item;

  @override
  State<EntryForm> createState() => EntryFormState();
}

class EntryFormState extends State<EntryForm> {
  late Item item = Item(name: '', price: 0, stok: 0);

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stokController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.item != null) {
      nameController.text = item.name;
      priceController.text = item.price.toString();
      stokController.text = item.stok.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: widget.item == null ? const Text('Tambah') : const Text('Ubah'),
        leading: const Icon(Icons.keyboard_arrow_left),
      ),
      body: ListView(
        children: <Widget>[
          // nama barang
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'Nama Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                onChanged: (value) {
                  // TODO: method untuk form nama barang
                }),
          ),
          //harga barang
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Harga Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                onChanged: (value) {
                  // TODO: method untuk form harga barang
                }),
          ),
          //stok barang
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
                controller: stokController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Stok Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                onChanged: (value) {
                  // TODO: method untuk form harga barang
                }),
          ),

          // tombol button
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Row(
              children: <Widget>[
                // tombol simpan
                Expanded(
                  child: ElevatedButton(
                    child: const Text(
                      'Save',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      if (widget.item == null) {
                        print('database');
                        // tambah data
                        item = Item(
                            name: nameController.text,
                            price: int.parse(priceController.text),
                            stok: int.parse(stokController.text));
                        final Future<Database> dbFuture = SqlHelper.db();
                        Future<int> id = SqlHelper.createItem(item);
                        print(id);
                      } else {
                        // ubah data
                        item.name = nameController.text;
                        item.price = int.parse(priceController.text);
                        item.stok = int.parse(stokController.text);
                        SqlHelper.updateItem(item);
                      }
                      print('ini data');

                      // kembali ke layar sebelumnya dengan membawa objek item
                      print(item.name);
                      Navigator.pop(context, item);
                    },
                  ),
                ),

                Container(
                  width: 5.0,
                ),

                // tombol batal
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.cancel),
                    label: const Text(
                      'Cancel',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


