

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

enum InvoiceTab { all, paid, due }


final invoiceTabProvider =
StateProvider<InvoiceTab>((ref) => InvoiceTab.all);
