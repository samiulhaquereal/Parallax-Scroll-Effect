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
      //print(_scrollOffset);

      //find middle of the screen
      if(_screenHeight == null || _layoutHeight == null) return;
      print('layout position - ${_scrollOffset*_layerSpeed1} ** middle of the screen - ${_screenHeight! * 0.6}');
      if(_scrollOffset * _layerSpeed1 > _screenHeight! * 0.6){
        print('reach to the middle');
        showText = true;
      }else{
        showText = false;
      }
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

  bool showText = false;

  double? _layoutHeight;
  double? _screenHeight;

  @override
  Widget build(BuildContext context) {
    var layoutHeight = MediaQuery.of(context).size.height * 3;
    var screenSize = MediaQuery.of(context).size;

    this._layoutHeight = layoutHeight;
    this._screenHeight = screenSize.height;

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
                bottom: screenSize.height * 0.1 + (_scrollOffset * _sunSpeed),
                right: screenSize.width * 0.3,
                left: 0,
                height: screenSize.height,
                child: SvgPicture.asset('assets/images/sun.svg')),
            Positioned(
                bottom: (_layerSpeed4 * _scrollOffset) + 5 ,
                right: _layerHSpeed4 * _scrollOffset * -1,
                left: _layerHSpeed4 * _scrollOffset * -1,
                height: screenSize.height,
                child: SvgPicture.asset('assets/images/mountains-layer-4.svg',alignment: Alignment.bottomCenter)),
            Positioned(
                bottom: (_layerSpeed3 * _scrollOffset) ,
                right: _layerHSpeed3 * _scrollOffset * -1,
                left: _layerHSpeed3 * _scrollOffset * -1,
                height: screenSize.height,
                child: SvgPicture.asset('assets/images/mountains-layer-2.svg',alignment: Alignment.bottomCenter)),
            Positioned(
                bottom: (_layerSpeed2 * _scrollOffset) - 5,
                right: _layerHSpeed2 * _scrollOffset * -1,
                left: _layerHSpeed2 * _scrollOffset * -1,
                height: screenSize.height,
                child: SvgPicture.asset('assets/images/trees-layer-2.svg',alignment: Alignment.bottomCenter)),
            Positioned(
                bottom:-15 + (_layerSpeed1 * _scrollOffset) ,
                right: _layerHSpeed1 * _scrollOffset * -1,
                left: _layerHSpeed1 * _scrollOffset * -1,
                height: screenSize.height,
                child: SvgPicture.asset('assets/images/layer-1.svg',fit: BoxFit.fitWidth,alignment: Alignment.bottomCenter,)),

            Positioned(
                top: screenSize.height + (_layerSpeed1 * _scrollOffset * -1)-40 ,
                right: 0,
                left: 0,
                height: screenSize.height + 20,
                child: Container(
                  color: Colors.black,
                  child: Center(
                      child: AnimatedOpacity(
                          opacity: showText ? 1 : 0,
                          duration: Duration(milliseconds: 750),
                          child: Text('This is the parallax effect',style: TextStyle(fontSize: 25,color: Colors.white),))),
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
