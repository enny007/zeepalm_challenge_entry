import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zeepalm_challenge_entry/components/text_widget.dart';
import 'package:zeepalm_challenge_entry/utils/colors.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.title,
    this.maxlines,
    this.isEnabled = true,
    required this.validator,
  });

  final TextEditingController controller;
  final String title;
  final String hint;
  final int? maxlines;
  final bool isEnabled;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: title,
          fontWeight: FontWeight.w500,
          fontsize: 20,
        ),
        const Gap(10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxlines,
            enabled: isEnabled,
            cursorColor: AppColors.primaryColor,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              border: InputBorder.none, // Remove border
            ),
          ),
        ),
      ],
    );
  }
}
