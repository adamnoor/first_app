import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(
          title: 'Flutter Demo App', word: 'These are the words', value: 0),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage(
      {super.key,
      required this.title,
      required this.word,
      required this.value});

  final String title;
  final String word;
  final int value;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _value = 0;
  String _word = "";
  String _display = "";
  String _displayPrompt = "";
  List<String> _wordsList = ["Alfa",
    "Bravo",
    "Charlie",
    "Delta",
    "Echo",
    "Foxtrot",
    "Golf",
    "Hotel",
    "India",
    "Juliett",
    "Kilo",
    "Lima",
    "Mike",
    "November",
    "Oscar",
    "Papa",
    "Quebec",
    "Romeo",
    "Sierra",
    "Tango",
    "Uniform",
    "Victor",
    "Whiskey",
    "X-ray",
    "Yankee",
    "Zulu",];

  void _incrementCounter() {
    setState(() {
      _value++;
      _display = _value.toString();
      _displayPrompt = "The Value is: ";
    });
  }

  void _decreaseCounter() {
    setState(() {
      _value--;
      _display = _value.toString();
      _displayPrompt = "The Value is: ";
    });
  }

  void _showWords(words) {
    setState(() {
      _word = words;
      if(_value >= _wordsList.length || _value < 0){
        _word= _wordsList[_wordsList.length-1];
      }
      else{
        _word = _wordsList[_value];
      }

      _display = _word;
      _displayPrompt = "The Words are: ";
    });
  }

  void _showValue() {
    setState(() {
      _display = _value.toString();
      _displayPrompt = "The Value is: ";
    });
  }

  void _goToCardScreen(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardPage()),
    );
  }

  @override
  void initState() {
    _word = widget.word;
    _display = "0";
    _displayPrompt = "The Value is: ";
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: [
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0, -.8),
                  child: ElevatedButton(
                    onPressed: _goToCardScreen,
                    child: const Text("Go to Cards Screen"),
                  ),
                ),

                Align(
                  alignment: Alignment(0, -0.1),
                  child: Text(_displayPrompt),
                ),
                Align(
                  alignment: Alignment(0, 0),
                  child: Text(_display),
                ),
                Align(
                  alignment: Alignment(.9, .9),
                  child: FloatingActionButton(
                    onPressed: _incrementCounter,
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ),
                ),
                Align(
                  alignment: Alignment(0, .6),
                  child: ElevatedButton(
                    onPressed: () {
                      _showWords(_word);
                    },
                    child: const Text("Show Words"),
                  ),
                ),
                Align(
                  alignment: Alignment(0, .8),
                  child: ElevatedButton(
                    onPressed: _showValue,
                    child: const Text("Show Value"),
                  ),
                ),
                Align(
                  alignment: Alignment(-.9, .9),
                  child: FloatingActionButton(
                    onPressed: _decreaseCounter,
                    tooltip: 'Decrease',
                    child: const Icon(Icons.remove),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  Suit suit = Suit.spades;
  CardValue value = CardValue.ace;

  // This style object overrides the styles for the suits, replacing the
  // image-based default implementation for the suit emblems with a text based
  // implementation.
  PlayingCardViewStyle myCardStyles = PlayingCardViewStyle(suitStyles: {
    Suit.spades: SuitStyle(
        builder: (context) => FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♠",
            style: TextStyle(fontSize: 500),
          ),
        ),
        style: TextStyle(color: Colors.grey[800])),
    Suit.hearts: SuitStyle(
        builder: (context) => FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♥",
            style: TextStyle(fontSize: 500),
          ),
        ),
        style: TextStyle(color: Colors.red)),
    Suit.diamonds: SuitStyle(
        builder: (context) => FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♦",
            style: TextStyle(fontSize: 500),
          ),
        ),
        style: TextStyle(color: Colors.red)),
    Suit.clubs: SuitStyle(
        builder: (context) => FittedBox(
          fit: BoxFit.fitHeight,
          child: Text(
            "♣",
            style: TextStyle(fontSize: 500),
          ),
        ),
        style: TextStyle(color: Colors.grey[800])),
    Suit.joker: SuitStyle(
        builder: (context) => Container()),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PlayingCardView(card: PlayingCard(suit, value), style: myCardStyles),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            DropdownButton<Suit>(
                value: suit,
                items: Suit.values
                    .map((s) =>
                    DropdownMenuItem(value: s, child: Text(s.toString())))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    suit = val!;
                  });
                }),
            DropdownButton<CardValue>(
                value: value,
                items: CardValue.values
                    .map((s) =>
                    DropdownMenuItem(value: s, child: Text(s.toString())))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    value = val!;
                  });
                }),
          ])
        ],
      ),
    );
  }
}