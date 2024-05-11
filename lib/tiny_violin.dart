import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TinyViolin extends StatefulWidget {
  const TinyViolin({super.key, required this.title});

  final String title;

  @override
  State<TinyViolin> createState() => _TinyViolinState();
}

class _TinyViolinState extends State<TinyViolin> {
  Offset pointer = Offset.zero;
  final player = AudioPlayer(playerId: 'tinyviolin');
  Future<void> playViolin() async {
    await player.play(AssetSource('audio/sad-violin.mp3'));
  }

  Future<void> stopViolin() async {
    player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: MouseRegion(
        cursor: SystemMouseCursors.none,
        onHover: (eve) {
          setState(() {
            pointer = eve.position;
          });
        },
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                playViolin();
              },
              onSecondaryTap: () {
                stopViolin();
              },
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Image(
                        width: 500,
                        image: AssetImage('assets/violin.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              left: pointer.dx - 100,
              top: pointer.dy - 100,
              child: const Image(
                width: 250,
                image: AssetImage('assets/violin-bow.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
