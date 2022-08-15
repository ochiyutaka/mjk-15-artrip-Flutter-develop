import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:state_notifier/state_notifier.dart';
import '/view/map/oldmap.dart';
import '/view/top/top.dart';

final appNameProvider = Provider((ref) => 'Special App!');

void main() {
  runApp(
    ProviderScope(
      //child: oldMap(),
      child: top(),
    ),
  );
}

// StatelessWidgetの代わりに `ConsumerWidget` を継承します。
class MyApp extends ConsumerWidget {
  // `ConsumerWidget` では、buildメソッドの引数に
  // `WidgetRef ref` が追加されます。
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // `ref.watch` を使用して Providerを読み取ります。
    final String value = ref.watch(appNameProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Example')),
        body: Center(
          // Providerから読み取った値を使用
          child: Text(value),
        ),
      ),
    );
  }
}
