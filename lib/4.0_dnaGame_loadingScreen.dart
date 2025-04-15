import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class DnaAnimationSequence extends StatefulWidget {
  @override
  _DnaAnimationSequenceState createState() => _DnaAnimationSequenceState();
}

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
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
              ),
            if (_showText1)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
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
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
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
                            padding: const EdgeInsets.all(20.0),
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
                style: TextStyle(color: const Color.fromARGB(
                                            255, 231, 153, 52), fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
