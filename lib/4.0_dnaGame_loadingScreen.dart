import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationSequence extends StatefulWidget {
  @override
  _AnimationSequenceState createState() => _AnimationSequenceState();
}

class _AnimationSequenceState extends State<AnimationSequence>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim0;
  late Animation<double> _anim1;
  late Animation<double> _anim2;
  bool _showText0 = true;
  bool _showText1 = false;
  bool _showText2 = false;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _anim0 = Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            _showText0 = false;
            _showText1 = true;
            _controller.reset();
            _controller.forward();
          });
        }
      });

    _anim1 = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _showText1 = false;
            _showText2 = true;
            _controller.reset();
            _controller.forward();
          });
        }
      });

    _anim2 = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _controller.repeat();
            _showButton = true;
          });
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffff9f3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_showText0)
              FadeTransition(
                opacity: _anim0,
                child: const Text('After the G1 Phase, cells undergo the S Phase in which their genetic material is duplicated. This is necessary so that each resulting daughter cell will have the same set of instructions to life. ', style: TextStyle(fontSize: 12), softWrap: true, maxLines: 8,),
              ),
            if (_showText1)
              const Text('DNA Replication start with the unwinding of the helix-shaped DNA. This is done by the Helicase enzyme, with the help of topoisomerase, which prevents supercoiling.', style: TextStyle(fontSize: 12)),
            if (_showText2)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text('Helicase then unzips the connected DNA strands by breaking the hydrogen bonds in between, creating a replication fork that is like an opened zipper. What follows is the actual creation of the copy DNA strands. Nitrogenous base pairs are matched with the parent strand, continuously added by the Polymerase enzyme.', style: TextStyle(fontSize: 12)),
                      const Text('If you are not familiar, the right pairing of the DNA bases are Adenind:Thymine and Cytosine:Guanine.', style: TextStyle(fontSize: 12)),
                      const Text('Now, it\'s your turn to duplicate the DNA!', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            AnimatedBuilder(
              animation: _showText1
                  ? _anim1
                  : _showText2
                      ? _anim2
                      : const AlwaysStoppedAnimation(0.0), //Prevent errors before anim1 starts
              builder: (context, child) {
                if (_showText1) {
                  return Opacity(
                    opacity: _anim1.value,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child:  Lottie.asset('assets/dna_unwinding.json'), // Replace with your Anim 1 widget
                    ),
                  );
                } else if (_showText2) {
                  return Opacity(
                    opacity: _anim2.value,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child:  Lottie.asset('assets/dna_unzipping.json'), // Replace with your Anim 2 widget
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            if (_showButton)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/dna_gamescreen');
                },
                child: const Text('Replicate the DNA'),
              ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// //loading screen will go for 10-20 seconds? yet to be seen

// class MyDNALoadingScreen extends StatelessWidget {
//   MyDNALoadingScreen({super.key});
//   bool playButtonInvisible = true;
//   bool playAnim1 = true;


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           //ANIMATION ORDER OF VISIBILITY
//           playAnim1
//               ? Column(
//                   children: [
//                     Lottie.asset('assets/dna_unzipping.json'),
//                     Container(
//                       margin: EdgeInsets.all(3),
//                       padding: EdgeInsets.all(6),
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text('DNA INFO.'),
//                     ),
//                   ],
//                 )
//               : Column(
//                   children: [
//                     Lottie.asset('assets/dna_unzipping.json'),
//                     Container(
//                       margin: EdgeInsets.all(3),
//                       padding: EdgeInsets.all(6),
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text('DNA INFO.'),
//                     ),
//                   ],
//                 ),

//               //BUTTON VISIBILITY
//               playButtonInvisible
//                   ? ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/dna_gamescreen');
//                       },
//                       child: Text('Replicate the DNA!'),
//                     )
//                   : Container()
//         ],
//       ),
//       backgroundColor: Colors.deepPurpleAccent[200],
//     );
//   }
// }
