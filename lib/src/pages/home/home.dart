import 'package:flutter/material.dart';
import 'package:odonto/src/config/app_data.dart' as appData;
import 'package:odonto/src/pages/home/components/item_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 26),
            children: [
              TextSpan(
                  text: 'Glossário de Oclusão',
                  style: TextStyle(color: Colors.black)),
            ],
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
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              physics: const BouncingScrollPhysics(),
              itemCount: appData.items.length,
              itemBuilder: (context, index) {
                return ItemTile(item: appData.items[index]);
              },
            ),
          )
        ],
      ),

      //list
    );
  }
}
