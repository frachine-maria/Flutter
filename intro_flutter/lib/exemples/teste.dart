import 'package:flutter/material.dart';

class CounterScreenValueNotifier extends StatefulWidget {
  const CounterScreenValueNotifier({super.key});

  @override
  State<CounterScreenValueNotifier> createState() => _CounterScreenValueNotifierState();
}

class _CounterScreenValueNotifierState extends State<CounterScreenValueNotifier> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final ValueNotifier<String> _message = ValueNotifier<String>('Toque nos botões para incrementar ou decrementar o contador');
  final ValueNotifier<Color> _counterColor = ValueNotifier<Color>(Colors.blue);

  @override
  // dipose = página para de escutar as informações, para não dar conflito
  void dispose() { 
    _counter.dispose();
    _message.dispose();
    _counterColor.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    _counter.value++;
    _updateMessageAndColor();
  }

  void _decrementCounter() {
    _counter.value--;
    _updateMessageAndColor();
  }

  void _resetCounter() {
    _counter.value = 0;
    _message.value = 'Contador resetado';
    _counterColor.value = Colors.blue;
  }

  void _updateMessageAndColor() {
    if (_counter.value == 0) {
      _message.value = 'Contador_zerado';
      _counterColor.value = Colors.blue;
    } else if (_counter.value > 0) {
      _message.value = 'Contador_positivo ${_counter.value}';
      _counterColor.value = Colors.green;
    } else {
      _message.value = 'Contador_negativo ${_counter.value}';
      _counterColor.value = Colors.red;
    }
  }

  Widget _buildButton({required VoidCallback onPressed, required String label, required Color color}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(label, style: const TextStyle(color: Colors.white)),
      icon: const SizedBox.shrink(),
      style: ElevatedButton.styleFrom(backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador Interativo'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder<Color>(
                valueListenable: _counterColor,
                builder: (context, color, _) {
                  return Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: color.withAlpha(1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: color, width: 2)),
                    child: Column(
                      children: [
                        const Text(
                          'Valor do contador:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        ValueListenableBuilder<int>(
                          valueListenable: _counter,
                          builder: (context, value, _) {
                            return Text(
                              '$value',
                              style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: color),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<String>(
                valueListenable: _message,
                builder: (context, msg, _) {
                  return Text(
                    msg,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    onPressed: _decrementCounter,
                    label: 'Decrementar',
                    color: Colors.red,
                  ),
                  _buildButton(
                    onPressed: _incrementCounter,
                    label: 'Incrementar',
                    color: Colors.green,
                  ),
                  _buildButton(
                    onPressed: _resetCounter,
                    label: 'Resetar',
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

