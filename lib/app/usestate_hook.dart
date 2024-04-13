// Using state full class

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Counter extends StatefulWidget {
  final int counter;

  const Counter({super.key, this.counter = 0});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int counter = 0;

  increment() {
    setState(() {
      counter += 1;
    });
  }

  @override
  void initState() {
    counter = widget.counter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("set state changing?");

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Counter is: $counter"),
            TextButton(onPressed: increment, child: const Text("Increment")),
          ],
        ),
      ),
    );
  }
}

// Using useState hook
class CounterUseState extends HookWidget {
  final int counter1;

  const CounterUseState({super.key, this.counter1 = 0});

  @override
  Widget build(BuildContext context) {
    final counter = useState(counter1);
    final subTractor = useState(3);

    print("useState state changing?");

    /*
    Above, you will notice that build function is being called on button press, but value
    of counter or subTractor does not goes to its original value, instead they maintain their state,
    this is due to useState hook, it carry its state, just like initState in stateful.
    In useState hook, the state is stored in .value property of ValueNotifier ([counter] or subTractor).
    But here, we write less code and complexity is reduced.
     */

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Counter is: ${counter.value}"),
            TextButton(
                onPressed: () => counter.value++,
                child: const Text("Increment")),
            Divider(),
            Text("SubTractor is: ${subTractor.value}"),
            TextButton(
                onPressed: () => subTractor.value--,
                child: const Text("Decrement SubTractor")),
          ],
        ),
      ),
    );
  }
}

class UseRefHook extends HookWidget {
  const UseRefHook({super.key});

  @override
  Widget build(BuildContext context) {
    /// using the focus node hook
    final focusNode = useFocusNode();

    /// using the TextEditingController hook
    final textController = useTextEditingController();

    /// useState() this renders every character entered by the user on a screen
    // final name = useState('');

    /// while useRef does not re-render build method, we use it when we just want
    /// to use value for computation and don't want to use it directly in UI
    final name = useRef('');
    useEffect(() {
      textController.addListener(() {
        name.value = textController.text;
      });
      return null;
    }, []);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            focusNode: focusNode,
            controller: textController,
            decoration: const InputDecoration(hintText: 'name'),
          ),
          SizedBox(),
          Text("use ref value: ${name.value}"),
          TextButton(
              onPressed: () {
                print("value is : ${name.value}");
              },
              child: Text("View value in console")),
        ],
      ),
    );
  }
}
