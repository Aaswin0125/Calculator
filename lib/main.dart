import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calculator',
    home: Calc(),
  ));
}

class Calc extends StatefulWidget {
  const Calc({Key? key}) : super(key: key);

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  Widget calbutton(String btntext, Color btncolor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
          onPressed: () {
            calculation(btntext);
          },
          child: Text(
            btntext,
            style: TextStyle(fontSize: 40, color: txtcolor),
          ),
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(5),
              fixedSize: Size.fromRadius(40),
              backgroundColor: btncolor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(child: Text('Simple Calculator')),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(text,
                      style: TextStyle(color: Colors.white, fontSize: 40)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(result,
                    style: TextStyle(color: Colors.white, fontSize: 60)),
              ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [calbutton('⌫', Colors.grey, Colors.green)],
            ),
            Divider(color: Colors.grey, thickness: 2, height: 10),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton('C', Colors.grey, Colors.orangeAccent),
                calbutton('()', Colors.grey, Colors.lightGreen),
                calbutton('%', Colors.grey, Colors.lightGreen),
                calbutton('÷', Colors.grey, Colors.lightGreen)
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton('7', Colors.grey, Colors.white),
                calbutton('8', Colors.grey, Colors.white),
                calbutton('9', Colors.grey, Colors.white),
                calbutton('x ', Colors.grey, Colors.lightGreen)
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton('4', Colors.grey, Colors.white),
                calbutton('5', Colors.grey, Colors.white),
                calbutton('6', Colors.grey, Colors.white),
                calbutton('- ', Colors.grey, Colors.lightGreen)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton('1', Colors.grey, Colors.white),
                calbutton('2', Colors.grey, Colors.white),
                calbutton('3', Colors.grey, Colors.white),
                calbutton('+ ', Colors.grey, Colors.lightGreen)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calbutton('+/-', Colors.grey, Colors.white),
                calbutton('0', Colors.grey, Colors.white),
                calbutton('.', Colors.grey, Colors.white),
                calbutton('=', Colors.green.shade800, Colors.lightGreenAccent),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  String text = '0';
  String expression='';
  String result = '0';

  void calculation(btnText) {
    setState(() {
      if (btnText == 'C') {
        text = '0';
        result = '0';
      } else if (btnText == '⌫') {
        text = text.substring(0, text.length - 1);
        if (text == '') {
          text = '0';
        }
      } else if (btnText == '=') {
        expression = text;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = 'Error';
        }
      }
      else {
        if (text == '0') {
          text = btnText;
        }else {
          text = text + btnText;
        }
      }
    });
  }
}
