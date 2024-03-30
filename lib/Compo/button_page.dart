import 'package:flutter/material.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool isGreenVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isGreenVisible = !isGreenVisible;
                });
              },
              child: AnimatedContainer(
                width: isGreenVisible ? 0 : 300,
                height: isGreenVisible ? 0 : 300,
                color: Colors.red,
                duration: Duration(milliseconds: 300),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Subtitle',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Button'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              right: isGreenVisible ? 0 : -300,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isGreenVisible = !isGreenVisible;
                  });
                },
                child: AnimatedContainer(
                  width: 300,
                  height: 300,
                  color: Colors.green,
                  duration: Duration(milliseconds: 300),
                  child: Center(
                    child: Text(
                      'Green Container',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ButtonPage(),
  ));
}
