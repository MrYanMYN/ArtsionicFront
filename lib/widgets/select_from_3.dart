import 'package:artsionic_app/utils/itemsState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:artsionic_app/styles.dart';

class SelectFrom3 extends StatefulWidget {
  @override
  _SelectFrom3State createState() => _SelectFrom3State();
}

class _SelectFrom3State extends State<SelectFrom3> {
  @override
  Widget build(BuildContext context) {
    int selectedOption =
        Provider.of<ItemsState>(context, listen: false).selectedRegion;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedOption = 0;
                      Provider.of<ItemsState>(context, listen: false)
                          .setRegion(selectedOption);
                    });
                  },
                  child: Text(
                    'Canada',
                    style: TextStyle(color: menuTextHeadingColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: selectedOption == 0
                        ? topicBackground
                        : unselectedOptionColor,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedOption = 1;
                      Provider.of<ItemsState>(context, listen: false)
                          .setRegion(selectedOption);
                    });
                  },
                  child: Text(
                    'United States',
                    style: TextStyle(color: menuTextHeadingColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: selectedOption == 1
                        ? topicBackground
                        : Color.fromARGB(255, 40, 50, 60),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedOption = 2;
                      Provider.of<ItemsState>(context, listen: false)
                          .setRegion(selectedOption);
                    });
                  },
                  child: Text(
                    'United Kingdom',
                    style: TextStyle(color: menuTextHeadingColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: selectedOption == 2
                        ? topicBackground
                        : Color.fromARGB(255, 40, 50, 60),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
