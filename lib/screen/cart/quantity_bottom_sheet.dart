// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecomm_app/provider/carts_provider.dart';
import 'package:flutter/material.dart';

import 'package:ecomm_app/models/carts_model.dart';
import 'package:ecomm_app/widgets/subtitle_texts.dart';
import 'package:provider/provider.dart';

class QuantityBottomSheet extends StatelessWidget {
  final CartModel cartModel;
  const QuantityBottomSheet({
    super.key,
    required this.cartModel,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 6,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.grey),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  cartProvider.updateQuantity(
                      productId: cartModel.productId, quantity: index + 1,);
                      Navigator.pop(context);
                },
                child: Center(
                  child: SubtitleText(label: '${index + 1}'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
