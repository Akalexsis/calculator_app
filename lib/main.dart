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
  // store int values separately to better perform calculation
  String num_1 = "";
  String num_2 = "";
  String operator = '';
  String? error;
  double? result;

  // append clicked value to num_1 only if no operator has been applied yet
  void _setValues(String value) {
    if ( operator.isEmpty ) {
      setState(() => num_1 += value );
    } else {
      setState(() => num_2 += value);
    }
  }

  // save selected value to operator if no operator has been selected yet, else display error message
  void _setOperator(String opp) {
    if (operator.isNotEmpty) {
      const useOperator = SnackBar(content: Text("An opperator has already been added"));
      ScaffoldMessenger.of(context).showSnackBar(useOperator);
    } else {
      setState(() => operator = opp);
    }
  }
  
  // ensure all input is filled before calculating the operation
  bool _isValidOperation() {
    if (num_1.isEmpty || num_2.isEmpty || operator.isEmpty) return false;
    return true;
  }

  void _clearAll() {
    setState(() => num_1 = '');
    setState(() => num_2 = '');
    setState(() => operator = '');
    setState(() => error = null);
    setState(() => result = null);
  }

  void _clearOperands() {
    setState(() => num_1 = '');
    setState(() => num_2 = '');
    setState(() => operator = '');
  }

  // perform desired operation to num_1 and num_2 and display result to screen
  void _operation() {
    if (_isValidOperation()){
      switch (operator){
        case '+':
          result = double.parse(num_1) + double.parse(num_2);
          break;  
        case '-':
          result = double.parse(num_1) - double.parse(num_2);
          break;
        case '/':
          if (double.parse(num_2) == 0){
            _clearOperands();
            setState(() => error = 'Divide by 0 Error'); // to display error message to screen, not pop-up
            break;
          }
          result = double.parse(num_1) / double.parse(num_2);
          break;
        case '*':
          result = double.parse(num_1) * double.parse(num_2);
          break;
      }
      _clearOperands();
      setState(() => result = result);
    } else {
      const includeData = SnackBar(content: Text("Please complete the expression"));
      ScaffoldMessenger.of(context).showSnackBar(includeData);
    }
  }

  // build needed to render elements to screen
  @override
  Widget build(BuildContext context) {
    return Scaffold( // holds app structure
      appBar: AppBar(
        title: Text('Calculator App'),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          child: Column(
          children: [
          Text((result != null)? '$result' : '$num_1 $operator $num_2'), // only display result after calculating expression
          Text((error != null) ? '$error' : ''),
          Expanded(
          child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                ElevatedButton(onPressed: _clearAll, child: Text('C')),
                ElevatedButton(onPressed: null, child: Text('Del')),
                ElevatedButton(onPressed: () { _setOperator("%"); }, child: Text('%')), // TO-DO - implement percent
                ElevatedButton(onPressed: () { _setOperator("/"); }, child: Text('/')),  // add to result var

                ElevatedButton(onPressed: () { _setValues("7"); }, child: Text('7')),
                ElevatedButton(onPressed: () { _setValues("8"); }, child: Text('8')),
                ElevatedButton(onPressed: () { _setValues("9"); }, child: Text('9')),
                ElevatedButton(onPressed: () { _setOperator("*"); }, child: Text('*')), // add to result var

                ElevatedButton(onPressed: () { _setValues("4"); }, child: Text('4')),
                ElevatedButton(onPressed: () { _setValues("5"); }, child: Text('5')),
                ElevatedButton(onPressed: () { _setValues("6"); }, child: Text('6')),
                ElevatedButton(onPressed: () { _setOperator("-"); }, child: Text('-')), // add to result var

                ElevatedButton(onPressed: () { _setValues("1"); }, child: Text('1')),
                ElevatedButton(onPressed: () { _setValues("2"); }, child: Text('2')),
                ElevatedButton(onPressed: () { _setValues("3"); }, child: Text('3')),
                ElevatedButton(onPressed: () { _setOperator("+"); }, child: Text('+')), // add to result var

                ElevatedButton(onPressed: () { _setValues("0"); }, child: Text('0')),
                ElevatedButton(onPressed: _operation, child: Text('=')), // perform operation
              ]))
            ]),
          )
        )
      );
  }
}
