import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoppingCart(),
    );
  }
}

class Product {
  final String name;
  final String color;
  final String size;
  final double price;
  int quantity;

  Product({
    required this.name,
    required this.color,
    required this.size,
    required this.price,
    this.quantity = 1,
  });
}

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final List<Product> products = [
    Product(
      name: 'Pullover',
      color: 'Black',
      size: 'L',
      price: 51.0,
    ),
    Product(
      name: 'T-Shirt',
      color: 'Gray',
      size: 'L',
      price: 30.0,
    ),
    Product(
      name: 'Sport Dress',
      color: 'Black',
      size: 'M',
      price: 43.0,
    ),
  ];

  double get totalAmount => products.fold(
    0,
        (previousValue, element) => previousValue + element.price * element.quantity,
  );

  void incrementQuantity(int index) {
    setState(() {
      if (products[index].quantity < 5) {
        products[index].quantity++;
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You have added 5 ${products[index].name} on your bag!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OKAY'),
              ),
            ],
          ),
        );
      }
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (products[index].quantity > 1) {
        products[index].quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(products[index].name),
              subtitle: Text('${products[index].color} / ${products[index].size}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => decrementQuantity(index),
                    icon: Icon(Icons.remove),
                  ),
                  Text('${products[index].quantity}'),
                  IconButton(
                    onPressed: () => incrementQuantity(index),
                    icon: Icon(Icons.add),
                  ),
                  Text('\$${(products[index].price * products[index].quantity).toStringAsFixed(2)}'),
                ],
              ),
            ),
          );

        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total amount:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${totalAmount.toStringAsFixed(2)}\$',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Congratulations!'),
                      ),
                    );
                  },
                  child: Text('CHECK OUT'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Set the button's border radius
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),



    );
  }
}
