import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _scrollController;

  @override
  void initState(){
    _scrollController = ScrollController()..addListener(() {
      _onScroll();
    });
    super.initState();
  }

  double _scrollOffset = 0.0;

  void _onScroll(){
    setState(() {
      _scrollOffset = _scrollController.offset;
      print(_scrollOffset);
    });
  }

  //Layers Speed
  double _layerSpeed1 = 0.5;
  double _layerSpeed2 = 0.45;
  double _layerSpeed3 = 0.42;
  double _layerSpeed4 = 0.375;
  double _sunSpeed = 0.18;

  //Layers Horizontal Speed
  double _layerHSpeed1 = 0.1;
  double _layerHSpeed2 = 0.08;
  double _layerHSpeed3 = 0.075;
  double _layerHSpeed4 = 0.07;

  @override
  Widget build(BuildContext context) {
    var layoutHeight = MediaQuery.of(context).size.height * 3;
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 66, 240, 210),
              Color.fromARGB(255, 253, 244, 193),
            ]
          )
        ),
        child: Stack(
          children: [
            Positioned(
                bottom: layoutHeight * 0.13 + (_scrollOffset * _sunSpeed),
                right: screenSize.width * 0.3,
                left: 0,
                child: SvgPicture.asset('assets/images/sun.svg')),
            Positioned(
                bottom: (_layerSpeed4 * _scrollOffset) - 45,
                right: 0,
                left: 0,
                child: SvgPicture.asset('assets/images/mountains-layer-4.svg')),
            Positioned(
                bottom: (_layerSpeed3 * _scrollOffset) -45,
                right: 0,
                left: 0,
                child: SvgPicture.asset('assets/images/mountains-layer-2.svg')),
            Positioned(
                bottom: (_layerSpeed2 * _scrollOffset) -45,
                right: 0,
                left: 0,
                child: SvgPicture.asset('assets/images/trees-layer-2.svg')),
            Positioned(
                bottom:-70 + (_layerSpeed1 * _scrollOffset) ,
                right: 0,
                left: 0,
                child: SvgPicture.asset('assets/images/layer-1.svg')),
            Positioned(
                top: screenSize.height + (_layerSpeed1 * _scrollOffset * -1) - 40 ,
                right: 0,
                left: 0,
                child: Container(
                  color: Colors.black,
                  height: layoutHeight,
                )),
            Positioned.fill(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: SizedBox(
                    height: layoutHeight,
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
