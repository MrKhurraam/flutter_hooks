import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_practice/app/usestate_hook.dart';

import 'app/useeditingcontroller_hook.dart';
import 'app/uselistenable_hook.dart';
import 'app/usememoize_hook.dart';
import 'app/usestream_hook.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyAppBody(),
    );
  }
}

class MyAppBody extends HookWidget {
  const MyAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            txtButton(context, const UseStreamHookExample()),
            txtButton(context, const CounterUseState()),
            txtButton(context, const UsingTextEditingControllerHook()),
            txtButton(context, const UseMemoizeHook()),
            txtButton(context, const UseListenableHook()),
            txtButton(context, const UseRefHook()),
          ],
        ),
      ),
    );
  }

  txtButton(context, page) {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ));
        },
        child: Text("${page}"));
  }
}
