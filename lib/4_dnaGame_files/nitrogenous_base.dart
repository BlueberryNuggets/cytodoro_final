import "package:flutter/material.dart";

class NitrogenousBase extends StatefulWidget {
  final String baseType;
  String baseChosen;
  NitrogenousBase(
      {required this.baseType, required this.baseChosen, super.key});

  @override
  State<NitrogenousBase> createState() => _NitrogenousBaseState();
}

class _NitrogenousBaseState extends State<NitrogenousBase> {
  String complementaryBaseType = "";
  List<Color> dnabaseColor = [
    Color(0xffc660e8), //A
    Color(0xffffda55), //T
    Color(0xffffb7b7), //C
    Color(0xffa7d648), //G
    Colors.transparent
  ];
  int basecolorIndex = 0;
  int complementcolorindex = 4;
  bool outline = false;

  @override
  void initState() {
    super.initState();
    _updateBaseColors();
    outline = true;
  }

  @override
  void didUpdateWidget(covariant NitrogenousBase oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.baseChosen != widget.baseChosen) {
      _updateBaseColors();
    }
  }

  void _updateBaseColors() {
    
    if (widget.baseType == "A") {
      complementaryBaseType = "T";
      basecolorIndex = 0;
    } else if (widget.baseType == "T") {
      complementaryBaseType = "A";
      basecolorIndex = 1;
    } else if (widget.baseType == "C") {
      complementaryBaseType = "G";
      basecolorIndex = 2;
    } else if (widget.baseType == "G") {
      complementaryBaseType = "C";
      basecolorIndex = 3;
    }

    if (widget.baseChosen == "A") {
      complementcolorindex = 0;
    } else if (widget.baseChosen == "T") {
      complementcolorindex = 1;
    } else if (widget.baseChosen == "C") {
      complementcolorindex = 2;
    } else if (widget.baseChosen == "G") {
      complementcolorindex = 3;
    } else {
      complementcolorindex = 4; // Default color if baseChosen is empty
    }

    // Set outline to true whenever baseChosen is updated
    outline = widget.baseChosen.isNotEmpty; 

    setState(() {}); // Rebuild to reflect color changes
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.2,
                  color: Colors.black,
                ),
                color: dnabaseColor[basecolorIndex],
              ),
              alignment: Alignment.center,
              width: 50,
              height: 200,
              child: Text(
                widget.baseType,
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.2,
                  color: outline ? Colors.black : Colors.transparent, // Conditional border color
                ),
                color: dnabaseColor[complementcolorindex],
              ),
              alignment: Alignment.center,
              width: 50,
              height: 208,
              child: Text(widget.baseChosen, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}
