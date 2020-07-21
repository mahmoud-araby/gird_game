import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<double> ballPosition = [];
  ScrollController girdController = ScrollController();
  ScrollController listViewController = ScrollController();
  double horizontalPadding = 30;
  double verticalPadding = 20;
  double ballStartPositionWidth;
  double ballStartPositionHeight;
  int currentHeightPosition = 1;
  int currentHeightTranslate = 0;
  int currentWidthTranslate = 0;
  int currentWidthPosition = 1;
  int awaitRight = 9;
  int awaitLeft = 9;
  int awaitTop = 15;
  int awaitBottom = 15;
  double gridHeight;
  double gridWidth;
  bool starting = false;

  @override
  Widget build(BuildContext context) {
    horizontalPadding = 30;
    verticalPadding = MediaQuery.of(context).size.width * 0.25 + 30;
    gridHeight = MediaQuery.of(context).size.height - horizontalPadding;
    gridWidth = MediaQuery.of(context).size.width - verticalPadding;
    ballStartPositionHeight = ((gridHeight / 16) / 2) - 10;
    ballStartPositionWidth = ((gridWidth / 9) / 2) - 10;
    if (!starting) {
      ballPosition = [
        ballStartPositionHeight,
        ballStartPositionWidth,
      ];
      MediaQuery.of(context).size.width;
      starting = true;
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button1(),
                Container(
                  height: gridHeight,
                  width: gridWidth,
                  child: ListView(
                    controller: listViewController,
                    shrinkWrap: true,
                    addAutomaticKeepAlives: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        width: gridWidth * 50 / 9,
                        height: gridHeight,
                        child: Stack(
                          children: [
                            GridView.builder(
                              controller: girdController,
                              itemCount: 50 * 50,
                              physics: NeverScrollableScrollPhysics(),
                              addAutomaticKeepAlives: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 50,
                                      childAspectRatio:
                                          (gridWidth / 9) / (gridHeight / 16)),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black87,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              top: ballPosition[0],
                              left: ballPosition[1],
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                button2(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  button2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              if (currentHeightPosition != 1) {
                setState(
                  () {
                    if (currentHeightPosition <= 36 &&
                        currentHeightTranslate != 0 &&
                        awaitTop == 1) {
                      currentHeightPosition--;
                      currentHeightTranslate--;
                      girdController.animateTo(
                          (gridHeight / 16) * currentHeightTranslate,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                      awaitBottom = 15;
                    } else {
                      ballPosition[0] -= gridHeight / 16;
                      currentHeightPosition--;
                      awaitTop != 1 ? awaitTop-- : awaitTop = awaitTop;
                    }
                  },
                );
              } else {
                return;
              }
            },
            icon: Icon(Icons.keyboard_arrow_up)),
        IconButton(
            onPressed: () {
              if (currentHeightPosition != 50) {
                setState(() {
                  if (currentHeightPosition >= 15 &&
                      currentHeightTranslate != 35 &&
                      awaitBottom == 1) {
                    currentHeightPosition++;
                    currentHeightTranslate++;
                    girdController.animateTo(
                        (gridHeight / 16) * currentHeightTranslate,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                    awaitTop = 15;
                  } else {
                    ballPosition[0] += gridHeight / 16;
                    currentHeightPosition++;
                    awaitBottom != 1
                        ? awaitBottom--
                        : awaitBottom = awaitBottom;
                  }
                });
              } else {
                return;
              }
            },
            icon: Icon(Icons.keyboard_arrow_down)),
      ],
    );
  }

  button1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (currentWidthPosition != 1) {
              setState(() {
                if (currentWidthPosition <= 42 &&
                    currentWidthTranslate != 0 &&
                    awaitLeft == 1) {
                  currentWidthPosition--;
                  currentWidthTranslate--;
                  ballPosition[1] -= gridWidth / 9;

                  listViewController.animateTo(
                      (gridWidth / 9) * currentWidthTranslate,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease);
                  awaitRight = 9;
                } else {
                  ballPosition[1] -= gridWidth / 9;
                  currentWidthPosition--;
                  awaitLeft != 1 ? awaitLeft-- : awaitLeft = awaitLeft;
                }
              });
            } else {
              return;
            }
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
        IconButton(
          onPressed: () {
            if (currentWidthPosition != 50) {
              setState(
                () {
                  if (currentWidthPosition >= 9 &&
                      currentWidthTranslate != 41 &&
                      awaitRight == 1) {
                    currentWidthPosition++;
                    currentWidthTranslate++;
                    ballPosition[1] += gridWidth / 9;

                    listViewController.animateTo(
                        (gridWidth / 9) * currentWidthTranslate,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                    awaitLeft = 9;
                  } else {
                    ballPosition[1] += gridWidth / 9;
                    currentWidthPosition++;
                    awaitRight != 1 ? awaitRight-- : awaitRight = awaitRight;
                  }
                },
              );
            } else {
              return;
            }
          },
          icon: Icon(
            Icons.keyboard_arrow_right,
          ),
        ),
      ],
    );
  }
}
