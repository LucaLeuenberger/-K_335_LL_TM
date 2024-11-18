import 'package:cyber_apocalypse/assets.dart';
import 'package:cyber_apocalypse/navigation/routes.dart';
import 'package:cyber_apocalypse/provider/character_provider.dart';
import 'package:cyber_apocalypse/ui/widgets/my_button.dart';
import 'package:flame/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class NeuGameScreen extends StatefulWidget {
  const NeuGameScreen({
    super.key,
  });

  @override
  _NeuGameScreenState createState() => _NeuGameScreenState();
}

class _NeuGameScreenState extends State<NeuGameScreen> {
  late CharacterProvider characterProvider;
  bool nameFilld = false;
  String playerName = '';

  @override
  void initState() {
    super.initState();
    characterProvider = Provider.of<CharacterProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Hier die Anpassung
      body: Material(
        child: Center(
          child: AspectRatio(
            aspectRatio: 9 / 19.5,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/ui/background1.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: LayoutBuilder(builder: (context, constrains) {
                  return Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          Image.asset('assets/ui/title.png'),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Name',
                                    hintStyle: TextStyle(color: Colors.white),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      playerName = value;
                                      nameFilld = true;
                                    } else {
                                      nameFilld = false;
                                    }
                                  },
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 65, bottom: 30, top: 40),
                                    child: Row(
                                      children: [
                                        IconButton(
                                            iconSize: 70,
                                            onPressed: () => {
                                                  context
                                                      .read<CharacterProvider>()
                                                      .changeCharacter()
                                                },
                                            icon: Icon(Icons.arrow_left),
                                            color: Colors.white),
                                        Consumer<CharacterProvider>(
                                          builder: (context, characterProvider,
                                              child) {
                                            return SpriteWidget(
                                              sprite: characterProvider.isSonic
                                                  ? Assets.sonicJump
                                                  : Assets.shadowJump,
                                            );
                                          },
                                        ),
                                        IconButton(
                                            iconSize: 70,
                                            onPressed: () => {
                                                  context
                                                      .read<CharacterProvider>()
                                                      .changeCharacter()
                                                },
                                            icon: Icon(Icons.arrow_right),
                                            color: Colors.white),
                                      ],
                                    )),
                                MyButton(
                                  'Spielen',
                                  onPressed: () => {
                                    if (nameFilld)
                                      {
                                        context.read<CharacterProvider>().setPlayerName(playerName),
                                        context.pushAndRemoveUntil(Routes.game)
                                      }
                                    else
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Bitte gib ein Name ein'),
                                        ))
                                      }
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
