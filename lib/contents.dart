import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const primaryColor = Color.fromARGB(255, 95, 113, 97);
const secondaryColor = Color.fromARGB(255, 197, 209, 199);

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    required this.textColor,
    required this.text,
    this.border,
  }) : super(key: key);

  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final BoxBorder? border;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 8,
      width: width * 38,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        border: border,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


              // Padding(
              //   padding: const EdgeInsets.only(left: 35, top: 10),
              //   child: Row(
              //     children: [
              //       const Icon(
              //         Icons.warning,
              //         size: 23,
              //       ),
              //       SizedBox(
              //         width: width * 1,
              //       ),
              //       const Text(
              //         "Kami akan mengirimkan SMS untuk Verifikasi Akun \nke nomor yang anda masukkan",
              //         style:
              //             TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              //       )
              //     ],
              //   ),
              // ),