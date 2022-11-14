import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final bool obSecure;
  final String initialValue;
  final bool readOnly;
  final TextEditingController? textEditingController;
  final void Function(String? value)? onSaved;
  final void Function(String? value)? onChanged;
  const CustomTextField({
    Key? key,
    this.textEditingController,
    this.readOnly = false,
    required this.hintText,
    required this.keyboardType,
    this.obSecure = false,
    this.onSaved,
    this.onChanged,
    this.initialValue = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.6),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: TextFormField(
            onChanged: onChanged,
            readOnly: readOnly,
            initialValue: initialValue,
            onSaved: onSaved,
            obscureText: obSecure,
            style: GoogleFonts.comfortaa(
              color: Colors.white,
              fontSize: 16,
            ),
            keyboardType: keyboardType,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: GoogleFonts.comfortaa(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
