import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      debugShowCheckedModeBanner: false,
      home: const CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => __CalculatorAppState();
}

class __CalculatorAppState extends State<CalculatorApp> {
  // declare variables here
  int val_1 = 0;
  int val_2 = 0;
  int result = 0;
  String operator = '';



  // declare functions here 
  void _operation() {
    switch (operator){
      case '+':
        val_1 + val_2;
        break;
      case '-':
        val_1 - val_2;
        break;
      case '/':
        if (val_1 == 0){
          print('Error, no division by 0');
        }
        val_1 / val_2;
        break;
      case '*':
        val_1 * val_2;
        break;
    }
  }

  // build needed to render elements to screen
  @override
  Widget build(BuildContext context) {
    return Scaffold( // holds app structure
      appBar: AppBar(
        title: Text('Calculator App'),
      ),
      body: GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              ElevatedButton(onPressed: _operation, child: Text('C')),
              ElevatedButton(onPressed: _operation, child: Text('7')),
              ElevatedButton(onPressed: _operation, child: Text('8')),
              ElevatedButton(onPressed: _operation, child: Text('9')),
              ElevatedButton(onPressed: _operation, child: Text('/')),  
              ElevatedButton(onPressed: _operation, child: Text('4')),
              ElevatedButton(onPressed: _operation, child: Text('5')),
              ElevatedButton(onPressed: _operation, child: Text('6')),
              ElevatedButton(onPressed: _operation, child: Text('*')),
              ElevatedButton(onPressed: _operation, child: Text('1')),
              ElevatedButton(onPressed: _operation, child: Text('2')),
              ElevatedButton(onPressed: _operation, child: Text('3')),
              ElevatedButton(onPressed: _operation, child: Text('-')),
              ElevatedButton(onPressed: _operation, child: Text('0')),
              
              ElevatedButton(onPressed: _operation, child: Text('+')),
              ElevatedButton(onPressed: _operation, child: Text('=')),
            ]
          ),
        );
  }
}
