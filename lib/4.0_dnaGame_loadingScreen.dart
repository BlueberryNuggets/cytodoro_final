import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//       routes: {
//         '/dna_loadingscreen': (context) => AnimationSequence(),
//       },
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

class DnaAnimationSequence extends StatefulWidget {
  @override
  _DnaAnimationSequenceState createState() => _DnaAnimationSequenceState();
}

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/dna_loadingscreen');
//               },
//               child: const Text('PMAT Explainer'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _DnaAnimationSequenceState extends State<DnaAnimationSequence>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
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
      duration: const Duration(seconds: 12),
      vsync: this,
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showText0 = false;
          _showText1 = true;
        });
        _controller.forward();
      }
    });

    _anim1 = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(seconds: 4), () {
            if (mounted) {
              setState(() {
                _showText1 = false;
                _showText2 = true;
              });
              _controller.reset();
              _controller.forward();
            }
          });
        }
      });

    _anim2 = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (mounted) {
            setState(() {
              Future.delayed(Duration(seconds: 8), () {
                _showButton = true;
              });
            });
          }
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
      backgroundColor: Color(0xfffff78b),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_showText0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'After the G1 Phase, cells undergo the S Phase in which their genetic material is duplicated. \nThis is necessary so that each resulting daughter cell will have the same set of instructions to life. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  softWrap: true,
                  maxLines: 8,
                ),
              ),
            if (_showText1)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        // Default style
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'DNA Replication start with the unwinding of the helix-shaped DNA. This is done by the '),
                          TextSpan(
                            text: 'Helicase',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black), // Orange color
                          ),
                          TextSpan(text: ' enzyme, with the help of '),
                          TextSpan(
                            text: 'Topoisomerase',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black), // Orange color
                          ),
                          TextSpan(text: ', which prevents supercoiling.'),
                        ],
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _anim1,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _anim1.value,
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Lottie.asset('assets/dna_unwinding.json'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            if (_showText2)
              Column(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Helicase then unzips the connected DNA strands by breaking the hydrogen bonds in between, creating a replication fork that is like an opened zipper. What follows is the actual creation of the copy DNA strands. Nitrogenous base pairs are matched with the parent strand, continuously added by the Polymerase enzyme. If you are not familiar, the right pairing of the DNA bases is: ',
                              textAlign: TextAlign.justify,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black), // Default style
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Adenine ',
                                    style: TextStyle(
                                        backgroundColor: Color(0xffc660e8),
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' : ',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 231, 153, 52),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' Thymine ',
                                    style: TextStyle(
                                        backgroundColor: Color(0xffffda55),
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '   and   ',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  TextSpan(
                                    text: ' Cytosine ',
                                    style: TextStyle(
                                        backgroundColor: Color(0xffffb7b7),
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' : ',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 231, 153, 52),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' Guanine    ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        backgroundColor: Color(0xffa7d648),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          const Text(
                            'Now, it\'s your turn to duplicate the DNA!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _anim2,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _anim2.value,
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Lottie.asset('assets/dna_unzipping.json'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            if (_showButton)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/dna_gamescreen');
                },
                child: Text('Replicate the DNA',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Future.delayed(Duration(milliseconds: 800), () {
                  Navigator.pushNamed(context, '/dna_gamescreen');
                });
              },
              child: Text(
                "Skip to DNA Game",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class AnimationSequence extends StatefulWidget {
//   @override
//   _AnimationSequenceState createState() => _AnimationSequenceState();
// }

// class _AnimationSequenceState extends State<AnimationSequence>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _anim0;
//   late Animation<double> _anim1;
//   late Animation<double> _anim2;
//   bool _showText0 = true;
//   bool _showText1 = false;
//   bool _showText2 = false;
//   bool _showButton = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 8),
//       vsync: this,
//     );

//     _anim0 = Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _controller.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           setState(() {
//             _showText0 = false;
//             _showText1 = true;
//             _controller.reset();
//             _controller.forward();
//           });
//         }
//       });

//     _anim1 = Tween<double>(begin: 0, end: 1).animate(_controller)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           setState(() {
//             _showText1 = false;
//             _showText2 = true;
//             _controller.reset();
//             _controller.forward();
//           });
//         }
//       });

//     _anim2 = Tween<double>(begin: 0, end: 1).animate(_controller)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           setState(() {
//             _controller.repeat();
//             _showButton = true;
//           });
//         }
//       });

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfffff9f3),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_showText0)
//               FadeTransition(
//                 opacity: _anim0,
//                 child: const Text('After the G1 Phase, cells undergo the S Phase in which their genetic material is duplicated. This is necessary so that each resulting daughter cell will have the same set of instructions to life. ', style: TextStyle(fontSize: 12), softWrap: true, maxLines: 8,),
//               ),
//             if (_showText1)
//               const Text('DNA Replication start with the unwinding of the helix-shaped DNA. This is done by the Helicase enzyme, with the help of topoisomerase, which prevents supercoiling.', style: TextStyle(fontSize: 12)),
//             if (_showText2)
//               SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       const Text('Helicase then unzips the connected DNA strands by breaking the hydrogen bonds in between, creating a replication fork that is like an opened zipper. What follows is the actual creation of the copy DNA strands. Nitrogenous base pairs are matched with the parent strand, continuously added by the Polymerase enzyme.', style: TextStyle(fontSize: 12)),
//                       const Text('If you are not familiar, the right pairing of the DNA bases are Adenind:Thymine and Cytosine:Guanine.', style: TextStyle(fontSize: 12)),
//                       const Text('Now, it\'s your turn to duplicate the DNA!', style: TextStyle(fontSize: 12)),
//                     ],
//                   ),
//                 ),
//               ),
//             AnimatedBuilder(
//               animation: _showText1
//                   ? _anim1
//                   : _showText2
//                       ? _anim2
//                       : const AlwaysStoppedAnimation(0.0), //Prevent errors before anim1 starts
//               builder: (context, child) {
//                 if (_showText1) {
//                   return Opacity(
//                     opacity: _anim1.value,
//                     child: SizedBox(
//                       width: 100,
//                       height: 100,
//                       child:  Lottie.asset('assets/dna_unwinding.json'), // Replace with your Anim 1 widget
//                     ),
//                   );
//                 } else if (_showText2) {
//                   return Opacity(
//                     opacity: _anim2.value,
//                     child: SizedBox(
//                       width: 100,
//                       height: 100,
//                       child:  Lottie.asset('assets/dna_unzipping.json'), // Replace with your Anim 2 widget
//                     ),
//                   );
//                 } else {
//                   return const SizedBox.shrink();
//                 }
//               },
//             ),
//             if (_showButton)
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/dna_gamescreen');
//                 },
//                 child: const Text('Replicate the DNA'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:lottie/lottie.dart';

// // //loading screen will go for 10-20 seconds? yet to be seen

// // class MyDNALoadingScreen extends StatelessWidget {
// //   MyDNALoadingScreen({super.key});
// //   bool playButtonInvisible = true;
// //   bool playAnim1 = true;


// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           //ANIMATION ORDER OF VISIBILITY
// //           playAnim1
// //               ? Column(
// //                   children: [
// //                     Lottie.asset('assets/dna_unzipping.json'),
// //                     Container(
// //                       margin: EdgeInsets.all(3),
// //                       padding: EdgeInsets.all(6),
// //                       alignment: Alignment.center,
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         borderRadius: BorderRadius.circular(5),
// //                       ),
// //                       child: Text('DNA INFO.'),
// //                     ),
// //                   ],
// //                 )
// //               : Column(
// //                   children: [
// //                     Lottie.asset('assets/dna_unzipping.json'),
// //                     Container(
// //                       margin: EdgeInsets.all(3),
// //                       padding: EdgeInsets.all(6),
// //                       alignment: Alignment.center,
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         borderRadius: BorderRadius.circular(5),
// //                       ),
// //                       child: Text('DNA INFO.'),
// //                     ),
// //                   ],
// //                 ),

// //               //BUTTON VISIBILITY
// //               playButtonInvisible
// //                   ? ElevatedButton(
// //                       onPressed: () {
// //                         Navigator.pushNamed(context, '/dna_gamescreen');
// //                       },
// //                       child: Text('Replicate the DNA!'),
// //                     )
// //                   : Container()
// //         ],
// //       ),
// //       backgroundColor: Colors.deepPurpleAccent[200],
// //     );
// //   }
// // }
