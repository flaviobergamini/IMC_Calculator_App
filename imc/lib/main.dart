import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController altura = TextEditingController();
  TextEditingController peso = TextEditingController();

  GlobalKey<FormState> _formulario = GlobalKey<FormState>();

  String _resultado = "Insira seus dados!";
  String _pesoMin = "";
  String _pesoMax = "";

  void _reset() {
    setState(() {
      altura.text = "";
      peso.text = "";
      _resultado = "Insira seus dados!";
      _pesoMin = "";
      _pesoMax = "";
    });
  }

  void _imc() {
    setState(() {
      double alturaPessoa = double.parse(altura.text);
      double pesoPessoa = double.parse(peso.text);
      double imc = pesoPessoa / (alturaPessoa * alturaPessoa);
      double pesoMin, pesoMax;
      print(imc);
      if (imc < 18.5 || imc > 24.9) {
        pesoMin = 18.5 * alturaPessoa * alturaPessoa;
        pesoMax = 24.9 * alturaPessoa * alturaPessoa;
        _pesoMin = "Peso ideal mínimo: ${pesoMin.toStringAsPrecision(3)}kg";
        _pesoMax = "Peso ideal máximo: ${pesoMax.toStringAsPrecision(3)}kg";
      }

      if (imc < 18.5) {
        _resultado = "Abaixo do peso: IMC (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.5 && imc < 24.9) {
        _resultado = "Peso ideal: IMC (${imc.toStringAsPrecision(3)})";
        _pesoMin = "";
        _pesoMax = "";
      } else if (imc >= 24.9 && imc < 29.9) {
        _resultado = "Sobrepeso: IMC (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _resultado = "Obesidade grau I: IMC (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _resultado = "Obesidade grau II: IMC (${imc.toStringAsPrecision(3)})";
      } else if (imc > 40) {
        _resultado = "Obesidade grau III: IMC (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC Calculator"),
        centerTitle: true,
        backgroundColor: Colors.brown,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _reset),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.00, 0.0, 10.0, 0.0),
        child: Form(
          key: _formulario,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120.0, color: Colors.brown),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (m)",
                  labelStyle: TextStyle(color: Colors.brown),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.brown, fontSize: 25.0),
                controller: altura,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Entre com a altura!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.brown),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.brown, fontSize: 25.0),
                controller: peso,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Entre com o peso!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formulario.currentState.validate()){
                        _imc();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.brown,
                  ),
                ),
              ),
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.brown, fontSize: 25.0),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0),
              ),
              Text(
                _pesoMin,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.brown, fontSize: 25.0),
              ),
              Text(
                _pesoMax,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.brown, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
