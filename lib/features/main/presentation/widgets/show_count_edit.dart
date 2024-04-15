import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/features/common/widgets/dialog_title.dart';
import 'package:tmed_kiosk/features/common/widgets/w_button.dart';

class ShowCountEdit extends StatefulWidget {
  const ShowCountEdit(
      {super.key, required this.controller, required this.maxCount});
  final TextEditingController controller;
  final int maxCount;

  @override
  State<ShowCountEdit> createState() => _ShowCountEditState();
}

class _ShowCountEditState extends State<ShowCountEdit> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(12),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      titlePadding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      title: const DialogTitle(title: "Vazifa haqida", isBottom: false),
      content: SizedBox(
        width: 362,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text('Vazifa haqida: '),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: contColor,
                        boxShadow: wboxShadow,
                        border: Border.all(color: white.withOpacity(.1)),
                      ),
                      padding: const EdgeInsets.fromLTRB(
                        12,
                        6,
                        12,
                        12,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: widget.controller,
                        decoration: const InputDecoration(
                          hintText: "Number",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            bottom: 12,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        validator: (value) {
                          final a = int.parse(value!);
                          if (widget.maxCount >= a || widget.maxCount == 0) {
                            return null;
                          } else {
                            return "Faqatgina ${widget.maxCount} tovar bor";
                          }
                        },
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              WButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, true);
                  }
                },
                text: 'Готово',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
