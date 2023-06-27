import 'package:flutter/material.dart';

class CardDashboard extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;
  final IconData? icon;
  final String section;
  final String? counter;

  const CardDashboard({
    Key? key,
    required this.onTap,
    this.color,
    this.icon,
    required this.section,
    this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.white, size: 30),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    section,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                counter.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
