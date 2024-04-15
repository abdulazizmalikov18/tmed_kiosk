import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/assets/themes/theme.dart';
import 'package:tmed_kiosk/features/cart/presentation/model/cart_view_model.dart';
import 'package:tmed_kiosk/features/common/widgets/w_textfield.dart';
import 'package:flutter/material.dart';

class TaskComment extends StatefulWidget {
  const TaskComment({
    super.key,
    required this.vm,
    this.comment = "",
  });

  final CartViewModel vm;
  final String comment;

  @override
  State<TaskComment> createState() => _TaskCommentState();
}

class _TaskCommentState extends State<TaskComment> {
  @override
  void initState() {
    if (widget.comment.isNotEmpty) {
      widget.vm.controllerComment.text = widget.comment;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: wdecoration2,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Vazifaga izoh",
            style: AppTheme.bodyLarge,
          ),
          const SizedBox(height: 12),
          WTextField(
            onChanged: (value) {},
            hintText: "Vazifaga izoh",
            maxLines: 5,
            contentPadding: const EdgeInsets.all(16),
            height: 120,
            controller: widget.vm.controllerComment,
          )
        ],
      ),
    );
  }
}
