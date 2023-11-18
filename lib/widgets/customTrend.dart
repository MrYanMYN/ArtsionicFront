import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:artsionic_app/utils/itemsState.dart';
import 'package:artsionic_app/styles.dart';

class FreeFormTrend extends StatelessWidget {
  const FreeFormTrend({
    super.key,
    required this.myController,
  });

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Center(
          child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 120,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextField(
                  controller: myController,
                  onEditingComplete: () {
                    Provider.of<ItemsState>(context, listen: false)
                        .acceptTopic(myController.text);
                    myController.clear();
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none, // Hide the underline
                    hintText: 'Enter Trend...',
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Provider.of<ItemsState>(context, listen: false)
                    .acceptTopic(myController.text);
                myController.clear();
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: colorGradient),
                    borderRadius: BorderRadius.circular(15)),
                child: Icon(
                  Icons.send,
                  color: buttonText,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
