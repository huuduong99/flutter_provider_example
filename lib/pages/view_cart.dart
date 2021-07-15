import 'package:flutter/material.dart';
import 'package:flutterprovider/view_model/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required this.cartModel}) : super(key: key);
  final CartModel cartModel;

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartModel _cartModel;

  @override
  void initState() {
    _cartModel = widget.cartModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartModel>.value(
        value: _cartModel,
        child: Consumer<CartModel>(
            builder: (BuildContext context, CartModel cart, Widget? child) {
          return Scaffold(
            body: Padding(
                padding:
                    const EdgeInsets.only(right: 20.0, left: 20.0, top: 50),
                child: cart.items.isEmpty ? _buildEmptyCart() : _buildCart()),
          );
        }));
  }

  Widget _buildEmptyCart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Nothing in cart',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Add items to cart',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.add_shopping_cart,
                color: Colors.blue,
                size: 20,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildCart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Hey there check your Items in cart',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.74,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height * 0.74) - 100,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Consumer<CartModel>(
                        builder: (BuildContext context, CartModel cart,
                                Widget? child) =>
                            Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                cart.items[index].name,
                              ),
                            ),
                            Text(
                              '${cart.items[index].quantity}',
                            ),
                            const SizedBox(
                              width: 130,
                            ),
                            Text(
                              '${cart.quantity(index) * cart.unitPrice}',
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: _cartModel.items.length,
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Total Price',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text('${_cartModel.totalPrice}')
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            _cartModel.clearItem();
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Text(
                'Clear Cart',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
