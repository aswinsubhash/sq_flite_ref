import 'package:flutter/material.dart';

class CartCountButton extends StatelessWidget {
  const CartCountButton({
    super.key,
    required this.isIncrement,
    this.isDelete = false,
    required this.onTap,
  });

  final bool isIncrement;
  final bool isDelete;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(),
      child: Material(
        elevation: 2,
        shape: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            isIncrement
                ? Icons.add
                : isDelete
                    ? Icons.delete
                    : Icons.remove,
            color: isDelete ? Colors.red : Colors.black,
          ),
        ),
      ),
    );
  }
}
