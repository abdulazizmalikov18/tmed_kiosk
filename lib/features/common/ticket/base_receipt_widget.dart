import 'package:flutter/foundation.dart';
import 'package:pdf/widgets.dart' as pw;

abstract class BaseReceiptWidget extends pw.StatelessWidget {
  Future<Uint8List> show();
}
