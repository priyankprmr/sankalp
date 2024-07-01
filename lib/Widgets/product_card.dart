import 'package:flutter/material.dart';
import 'package:sankalp/Utils/string_const.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Product Code Here"),
                SizedBox(
                  height: 5.0,
                ),
                Text("Case No. Here"),
                SizedBox(
                  height: 5.0,
                ),
                Text("Batch No. Here"),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: StringConst.qty,
              ),
            ),
          )
        ],
      ),
    );
  }
}
