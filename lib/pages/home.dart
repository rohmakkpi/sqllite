import 'package:flutter/material.dart';
import 'package:sqllite/helpers/dbhelpers.dart';
import 'package:sqllite/pages/entryForm.dart';
import 'package:sqflite/sqflite.dart';
import '../models/item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  int count = 0;
  List<Item> itemList = [];

  @override
  void initState() {
    updateListView();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Item'),
        ),
        body: Column(
          children: [
            Expanded(
              child: createListView(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Tambah Item'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EntryForm(),
                      ),
                    ).then((value) {
                      updateListView();
                    });
                  },
                ),
              ),
            )
          ],
        ));
  }

  ListView createListView() {
    TextStyle? textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) => Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.purpleAccent,
                  child: Icon(Icons.ad_units),
                ),
                title: Text(
                  itemList[index].name,
                  style: textStyle,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Harga: ${itemList[index].price.toString()}'),
                    Text('Stok: ${itemList[index].stok.toString()}'),
                  ],
                ),
                trailing: GestureDetector(
                  child: const Icon(Icons.delete),
                  onTap: () async {
                    await SqlHelper.deleteItem(itemList[index].id);
                    updateListView();
                  },
                ),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EntryForm(item: itemList[index]),
                    ),
                  ).then((value) {
                    updateListView();
                  });
                },
              ),
            ));
  }

  void deleteItem(int id) async {
    await SqlHelper.deleteItem(id);
    updateListView();
  }

  void updateListView() {
    final Future<Database> dbFuture = SqlHelper.db();
    dbFuture.then((database) {
      // TODO: get all item from DB
      Future<List<Item>> itemListFuture = SqlHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          count = itemList.length;
        });
      });
    });
  }
}