import 'package:flutter/material.dart';
import 'package:odonto/src/config/app_data.dart' as appData;
import 'package:odonto/src/views/home/components/item_tile.dart';

import '../../models/item_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _searchText = '';

  List<ItemModel> searchItems() {
    return appData.items.where((item) {
      final nameLower = item.name.toLowerCase();
      final searchTextLower = _searchText.toLowerCase();
      return nameLower.contains(searchTextLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Glossário de Oclusão',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
          ),
        ),
      ),

      body: Column(
        children: [
          //Campo de pesquisa
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                hintText: 'Pesquisar...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              physics: const BouncingScrollPhysics(),
              itemCount: searchItems().length,
              itemBuilder: (context, index) {
                return ItemTile(item: searchItems()[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
