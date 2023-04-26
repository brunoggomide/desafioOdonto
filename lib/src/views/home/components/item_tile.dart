import 'package:flutter/material.dart';
import 'package:odonto/src/models/item_model.dart';
import 'package:odonto/src/views/descriptions/description_screen.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) {
              return DescriptionScreen(item: item);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white70),
        child: ListTile(
          title: Text(item.name),
          trailing: const Icon(Icons.arrow_forward_ios),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
