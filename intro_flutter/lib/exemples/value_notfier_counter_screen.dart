import 'package:flutter/material.dart';

class CounterScreenValueNotifier extends StatefulWidget {
  const CounterScreenValueNotifier({super.key});

  @override
  State<CounterScreenValueNotifier> createState() => _CounterScreenValueNotifierState();
}

class _CounterScreenValueNotifierState extends State<CounterScreenValueNotifier> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  // guarda o número do contudador
  final ValueNotifier<String> _message = ValueNotifier<String>('Toque nos botões para incrementar ou decrementar o contador');
  // guarda a mensagem do contador
  final ValueNotifier<Color> _counterColor = ValueNotifier<Color>(Colors.blue);
// guarda a cor do contador

  @override
  // dipose = página para de escutar as informações, para não dar conflito. 
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador Interativo'),
        backgroundColor: Colors.pink,
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
                  ElevatedButton.icon(
                    onPressed: _decrementCounter,
                    label: Text('Decrementar', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                  ElevatedButton.icon(
                    onPressed: _incrementCounter,
                    label: Text('Incrementar', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                  ElevatedButton.icon(
                    onPressed: _resetCounter,
                    label: Text('Resetar', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
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

