import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Future<String> getData() async {
  await Future.delayed(const Duration(seconds: 3));
  print("after 3 second");
  return "Data received";
}

class UseMemoizeHook extends HookWidget {
  const UseMemoizeHook({super.key});

  @override
  Widget build(BuildContext context) {
    // useMemoize cache result, and when widget will rebuild,
    // it will return the previously cache result;
    final memo = useMemoized(() => getData());

    /*
    * We can use getData directly into useFuture hook, but we didnot because,
    * useFuture will call build method when ever it will recieve data.
    * If we will directly use getData inside useFuture, then getData will be
    * recalled when useFuture will call build function, thus going into loop.
    *
    * Thus we utilize useMemoized hook, so that it will return cached data when
    * useFuture will call build method, and it will not go into loop,
    * because getData() will be called only once inside useMemoized, so build
    * will be called only once after data received
    * */
    final data = useFuture(memo);

    print("UseMemoizeHook called?");

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
              Text("Data from memoized: ${data.data ?? "Loading data"}"),
            ],
          ),
        ),
      ),
    );
  }
}
