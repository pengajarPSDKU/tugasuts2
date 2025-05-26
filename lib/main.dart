import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Calculator",
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentNumber = "";
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operation = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "CLEAR") {
        _output = "0";
        _currentNumber = "";
        _num1 = 0.0;
        _num2 = 0.0;
        _operation = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "X" ||
          buttonText == "/") {
        _num1 = double.parse(_output);
        _operation = buttonText;
        _output = "0";
        _currentNumber = "";
      } else if (buttonText == ".") {
        if (_output.contains(".")) {
          return;
        } else {
          _output = _output + buttonText;
          _currentNumber = _currentNumber + buttonText;
        }
      } else if (buttonText == "=") {
        _num2 = double.parse(_output);
        if (_operation == "+") {
          _output = (_num1 + _num2).toString();
        }
        if (_operation == "-") {
          _output = (_num1 - _num2).toString();
        }
        if (_operation == "X") {
          _output = (_num1 * _num2).toString();
        }
        if (_operation == "/") {
          if (_num2 == 0.0) {
            _output = "Error";
          } else {
            _output = (_num1 / _num2).toString();
          }
        }
        _num1 = 0.0;
        _num2 = 0.0;
        _operation = "";
        _currentNumber = "";
      } else {
        _output = _output == "0" ? buttonText : _output + buttonText;
        _currentNumber = _currentNumber + buttonText;
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(24.0),
          textStyle: const TextStyle(fontSize: 20.0),
        ),
        onPressed: () => _buttonPressed(buttonText),
        child: Text(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/")
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("X")
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-")
                ],
              ),
              Row(
                children: [
                  _buildButton("."),
                  _buildButton("0"),
                  _buildButton("00"),
                  _buildButton("+")
                ],
              ),
              Row(
                children: [
                  _buildButton("CLEAR"),
                  _buildButton("="),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
