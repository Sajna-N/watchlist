import 'package:flutter/material.dart';

class CardItems extends StatelessWidget {
  const CardItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(10),
      color: const Color.fromARGB(255, 105, 139, 156),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Commodity 1',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: const <Widget>[
                    Text(
                      'Opening Stock',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      ' Bought/Sold ',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Closing Stock',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                )
              ],
            ),
            const Text(
              'id',
              style: TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}

// Center(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: const <Widget>[
          //         SizedBox(
          //           height: 10,
          //         ),
          //         CardItems(),
          //         SizedBox(
          //           height: 10,
          //         ),
          //         CardItems()
          //       ],
          //     ),
          //   ),
          // ),



        // final tabs = _splitItemsIntoTabs(users);


