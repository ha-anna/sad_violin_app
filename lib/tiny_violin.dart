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
  bool isPlayerOn = false;
  final player = AudioPlayer(playerId: 'tinyviolin');
  Future<void> playViolin() async {
    await player.play(AssetSource('audio/sad-violin.mp3'));
    setState(() {
      isPlayerOn = true;
    });
  }

  void stopViolin() {
    player.stop();
    setState(() {
      isPlayerOn = false;
    });
  }

  Future<void> handleViolin() async {
    if (isPlayerOn) {
      stopViolin();
    } else {
      await playViolin();
    }
  }

  void _updatePointerPosition(PointerEvent event) {
    setState(() {
      pointer = event.position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Listener(
        onPointerMove: _updatePointerPosition,
        child: MouseRegion(
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
                  handleViolin();
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
      ),
    );
  }
}
