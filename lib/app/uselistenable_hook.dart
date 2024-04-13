import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseListenableHook extends HookWidget {
  const UseListenableHook({super.key});

  @override
  Widget build(BuildContext context) {
    final countDown = useMemoized(() => CountDown(from: 20));

    // useListenable listen the value
    final listenable = useListenable(countDown);

    return Scaffold(
      appBar: AppBar(
        title: Text("UseMemoizeHook ${DateTime.now().second}"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Data from Listenable: ${listenable.value}"),
            ],
          ),
        ),
      ),
    );
  }
}

class CountDown extends ValueNotifier<int> {
  late StreamSubscription streamSubscription;

  CountDown({required int from}) : super(from) {
    streamSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (computationCount) {
        return from - computationCount;
      },
    ).takeWhile((element) => element >= 0).listen((event) {
      value = event;
    });
  }
}
