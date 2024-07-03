import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Dispatch/Notifiers/product_list_notifier.dart';

final productListProvider = ChangeNotifierProvider<ProductListNotifier>((ref) => ProductListNotifier());
