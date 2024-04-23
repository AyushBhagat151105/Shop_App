import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widget/cart_provider.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Cart Page'),
        ),
      ),
      body: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final cartItem = cart[index];

            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                radius: 30,
                backgroundImage: AssetImage(cartItem['imageUrl'].toString()),
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete Product',
                          style: Theme.of(context).textTheme.titleMedium,
                          ),
                          content: const Text('Are you sure ypu wnat to remove the product from your cart'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              child:const Text('No', style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<CartProvider>(context, listen: false).removeProduct(cartItem);
                                Navigator.of(context).pop();
                              },
                              child:const Text('Yes', style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                          ],
                        );
                      },
                  );
                },
                icon: const Icon(Icons.delete, color: Colors.red,
                ),
              ),
              title: Text(cartItem['title'].toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text('Size: ${cartItem['sizes']}'),
            );
          },
      ),
    );
  }
}
