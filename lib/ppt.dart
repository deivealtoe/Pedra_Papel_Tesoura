import 'package:flutter/material.dart';
import 'dart:math';

class JogoPPT extends StatefulWidget {
  const JogoPPT({Key? key}) : super(key: key);

  @override
  State<JogoPPT> createState() => _JogoPPTState();
}

class _JogoPPTState extends State<JogoPPT> {
  String _imgUserPlayer = "imagens/indefinido.png";
  String _imgAppPlayer = "imagens/indefinido.png";

  int _userPoints = 0;
  int _appPoints = 0;
  int _tiePoints = 0;

  Color _borderUserColor = Colors.transparent;
  Color _borderAppColor = Colors.transparent;

  String _obtemEscolhaApp() {
    var opcoes = ["pedra", "papel", "tesoura"];
    var valorEscolhido = opcoes[Random().nextInt(3)];
    return valorEscolhido;
  }

  void _iniciaJogada(String opcao) {
    setState(() {
      _imgUserPlayer = "imagens/$opcao.png";
    });

    String escolhidoParaApp = _obtemEscolhaApp();

    setState(() {
      _imgAppPlayer = "imagens/$escolhidoParaApp.png";
    });

    _terminaJogada(opcao, escolhidoParaApp);
  }

  void _terminaJogada(String escolhaUser, String escolhaApp) {
    var resultado = "indefinido";

    switch (escolhaUser) {
      case "pedra":
        if (escolhaApp == "papel") {
          resultado = "app";
        } else if (escolhaApp == "tesoura") {
          resultado = "user";
        } else {
          resultado = "empate";
        }
        break;
      case "papel":
        if (escolhaApp == "pedra") {
          resultado = "user";
        } else if (escolhaApp == "tesoura") {
          resultado = "app";
        } else {
          resultado = "empate";
        }
        break;
      case "tesoura":
        if (escolhaApp == "pedra") {
          resultado = "app";
        } else if (escolhaApp == "papel") {
          resultado = "user";
        } else {
          resultado = "empate";
        }
        break;
    }

    setState(() {
      if (resultado == "user") {
        _userPoints++;
        _borderAppColor = Colors.transparent;
        _borderUserColor = Colors.green;
      } else if (resultado == "app") {
        _appPoints++;
        _borderAppColor = Colors.green;
        _borderUserColor = Colors.transparent;
      } else {
        _tiePoints++;
        _borderAppColor = Colors.orange;
        _borderUserColor = Colors.orange;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Pedra-Papel-Tesoura ;-)"),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text("Disputa", style: TextStyle(fontSize: 26.0)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BadgeBatalha(
                  borderPlayer: _borderUserColor,
                  imgPlayer: _imgUserPlayer,
                  height: 120,
                ),
                const Text(" VS "),
                BadgeBatalha(
                  borderPlayer: _borderAppColor,
                  imgPlayer: _imgAppPlayer,
                  height: 120,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text("Placar", style: TextStyle(fontSize: 26)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BadgePlacar(nomePlacar: "Você", pontosDoPlacar: _userPoints),
                BadgePlacar(nomePlacar: "Empate", pontosDoPlacar: _tiePoints),
                BadgePlacar(nomePlacar: "Máquina", pontosDoPlacar: _appPoints),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text("Opções", style: TextStyle(fontSize: 26)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Image.asset("imagens/pedra.png", height: 80),
                  onTap: () => _iniciaJogada("pedra"),
                ),
                GestureDetector(
                  child: Image.asset("imagens/papel.png", height: 80),
                  onTap: () => _iniciaJogada("papel"),
                ),
                GestureDetector(
                  child: Image.asset("imagens/tesoura.png", height: 80),
                  onTap: () => _iniciaJogada("tesoura"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BadgeBatalha extends StatelessWidget {
  const BadgeBatalha({
    required Color borderPlayer,
    required String imgPlayer,
    required double height,
  })  : _borderPlayer = borderPlayer,
        _imgPlayer = imgPlayer,
        _height = height;

  final Color _borderPlayer;
  final String _imgPlayer;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _borderPlayer, width: 5),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      child: Image.asset(
        _imgPlayer,
        height: _height,
      ),
    );
  }
}

class BadgePlacar extends StatelessWidget {
  const BadgePlacar({
    Key? key,
    required String nomePlacar,
    required int pontosDoPlacar,
  })  : _nomePlacar = nomePlacar,
        _pontosDoPlacar = pontosDoPlacar;

  final String _nomePlacar;
  final int _pontosDoPlacar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_nomePlacar),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(7)),
          ),
          padding: const EdgeInsets.all(35),
          child: Text(
            '$_pontosDoPlacar',
            style: const TextStyle(fontSize: 26),
          ),
        ),
      ],
    );
  }
}
