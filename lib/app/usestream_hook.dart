import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Stream<String> getTime() => Stream.periodic(
      const Duration(seconds: 1),
      (count) {
        print("count: $count");
        return DateTime.now().toString();
      },
    );

class UseStreamHookExample extends StatelessWidget {
  const UseStreamHookExample({super.key});

  @override
  Widget build(BuildContext context) {
    print("UseStreamHookExample changes?");

    return Scaffold(
      appBar: AppBar(
        title: const Text("UseStreamHookExample:"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UseStreamHook(),
            // StatelessUseStream(),
          ],
        ),
      ),
    );
  }
}

class UseStreamHook extends HookWidget {
  const UseStreamHook({super.key});

  @override
  Widget build(BuildContext context) {
    final AsyncSnapshot<String> dateTime = useStream(getTime());
    print("UseStreamHook changes?");
    return Text("Datetime stream value is: ${dateTime.data ?? "Loading data"}");
  }
}

class StatelessUseStream extends StatelessWidget {
  const StatelessUseStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: getTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading time...");
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Text('Current Time: ${snapshot.data}',
              style: TextStyle(fontSize: 20));
        } else {
          return const Text("No data");
        }
      },
    );
  }
}
