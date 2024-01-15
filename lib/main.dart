import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoppingBag(),
    );
  }
}

class ShoppingBag extends StatefulWidget {
  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  Map<String, int> items = {
    'Pullover': 1,
    'T-Shirt': 1,
    'Sport Dress': 1,
  };

  Map<String, int> prices = {
    'Pullover': 51,
    'T-Shirt': 30,
    'Sport Dress': 43,
  };

  Map<String, bool> isDisabled = {
    'Pullover': false,
    'T-Shirt': false,
    'Sport Dress': false,
  };

  void _showDialog(String itemName, int quantity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have added $quantity $itemName on your bag!'),
          actions: <Widget>[
            TextButton(
              child: Text('OKAY'),
              onPressed: () { Navigator.of(context).pop(); },
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar() {
    final snackBar = SnackBar(content: Text('Congratulations on checking out!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  int get totalAmount => items.keys.fold(0, (sum, key) => sum + (prices[key] ?? 0) * (items[key] ?? 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: Text(
          'My Bag',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                String key = items.keys.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        key,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (items[key] != null && items[key]! > 0) {
                                  items[key] = (items[key] ?? 0) - 1;
                                  isDisabled[key] = false;
                                }
                              });
                            },
                          ),
                          Text(
                            '${items[key] ?? 0}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                if (items[key] == 5) {
                                  isDisabled[key] = true;
                                }
                                if (items[key] != null && items[key]! < 5) {
                                  items[key] = (items[key] ?? 0) + 1;
                                  if (items[key] == 5) {
                                    _showDialog(key, items[key]!);
                                  }
                                }
                              });
                            },
                            disabledColor: Colors.grey,
                            //disabledTextColor: Colors.white,
                            color: Colors.blue,
                            //textColor: Colors.white,
                            iconSize: 24,
                            padding: EdgeInsets.all(16),
                            splashRadius: 24,
                            tooltip: 'Add',
                            splashColor: Colors.blueAccent,
                            highlightColor: Colors.blueAccent,
                            //disabled: isDisabled[key],
                          ),
                          Text(
                            '\$${prices[key]! * items[key]!}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${totalAmount}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

            ),
          ),
          // Button at the bottom
          //SizedBox(height: 20), // Add spacing
          SizedBox(
            width: double.infinity, // Full width
            child: ElevatedButton(
              onPressed: _showSnackBar,
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Set the button color to red
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Set the button's border radius
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'CHECK OUT',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),


        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _showSnackBar,
      //   child: Icon(Icons.check),
      // ),
    );
  }
}
