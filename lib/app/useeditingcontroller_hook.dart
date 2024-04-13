import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UsingTextEditingControllerHook extends HookWidget {
  const UsingTextEditingControllerHook({super.key});

  @override
  Widget build(BuildContext context) {
    // This controller has its own state, so it will not reset itself on hot reload.
    final controller = useTextEditingController();

    print("UsingTextEditingController changes?");
    return Scaffold(
      appBar: AppBar(
        title: Text("ControllerHook ${DateTime.now().second}"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
              ),
              utilizeController(controller),
            ],
          ),
        ),
      ),
    );
  }

  utilizeController(controller) {
    print("inside utilizeController");
    return UtilizingController(
      controller: controller,
    );
  }
}

class UtilizingController extends HookWidget {
  final controller;

  const UtilizingController({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // use state works just like setstate, it rebuild build method
    final text = useState('type something in textfield \n');

    // use effect is void call back, and it doesnot have its own state
    // thats why we need to pass it list of keys, so that it will keep its state
    // as long as key is same, when key will change, it will reset itselt.
    useEffect(() {
      // listening to controller, so that whenever its value will change , we
      // will pass that value to useState, and it will notify its listener
      controller.addListener(() {
        text.value = controller.text;
      });
      return null;
    }, [controller]);

    print("UtilizingController changes?");
    return Text("You type: ${text.value}");
  }
}
