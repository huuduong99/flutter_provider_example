import 'package:flutter/material.dart';
import 'package:flutterprovider/model/product.dart';
import 'package:flutterprovider/pages/view_cart.dart';
import 'package:flutterprovider/view_model/cart.dart';
import 'package:provider/provider.dart';

class MyCatalog extends StatefulWidget {
  const MyCatalog({Key? key}) : super(key: key);

  @override
  _MyCatalogState createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  final List<Product> catalogItems = <Product>[
    Product(id: 0, name: 'Phone', quantity: 1),
    Product(id: 1, name: 'Tablet', quantity: 1),
    Product(id: 2, name: 'Watch', quantity: 1),
    Product(id: 3, name: 'Mac', quantity: 1),
    Product(id: 4, name: 'Charger', quantity: 1),
    Product(id: 5, name: 'Mouse', quantity: 1),
    Product(id: 6, name: 'Keyboard', quantity: 1),
    Product(id: 7, name: 'Screen', quantity: 1),
    Product(id: 8, name: 'Monitor', quantity: 1),
    Product(id: 9, name: 'Desk', quantity: 1),
    Product(id: 10, name: 'TrackPad', quantity: 1),
  ];

  final CartModel _cartModel = CartModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartModel>.value(
        value: _cartModel,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
            actions: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 20),
                width: 20,
                height: 20,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.shopping_cart,
                      size: 24,
                    ),
                    Positioned(
                        top: 6,
                        right: -10,
                        child: CircleAvatar(
                          radius: 11,
                          child: Consumer<CartModel>(builder:
                              (BuildContext context, CartModel cart,
                                  Widget? child) {
                            return Text('${cart.totalCountProduct}');
                          }),
                        ))
                  ],
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(
                top: 10, right: 20.0, left: 20.0, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'What do you want to buy?',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.77,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 20),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  catalogItems[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                const Text(''),
                                GestureDetector(
                                  onTap: () {
                                    if (_cartModel.items
                                        .contains(catalogItems[index])) {
                                      catalogItems[index].quantity++;
                                      _cartModel.addCount();
                                    } else {
                                      _cartModel.addItem(
                                          index, catalogItems[index]);
                                      _cartModel.addCount();
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Center(
                                        child: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        );
                      },
                      itemCount: catalogItems.length,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => CartScreen(
                          cartModel: _cartModel,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        'View Cart',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
