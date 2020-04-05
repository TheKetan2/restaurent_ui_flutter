import 'package:flutter/material.dart';
import "package:flutter_food_delivery_ui/data/data.dart";
import 'package:flutter_food_delivery_ui/models/order.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  _buildCartItem(Order order) {
    return Container(
      padding: EdgeInsets.all(
        20.0,
      ),
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15.0,
        ),
        border: Border.all(width: 1.0, color: Colors.grey[200]),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: AssetImage(order.food.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(
                12.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    order.food.name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    order.restaurant.name,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 100.0,
                    // height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        width: 0.8,
                        color: Colors.black,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "-",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          order.quantity.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "+",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(18.0),
            child: Text(
              "\$${order.quantity * order.food.price}",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    currentUser.cart.forEach(
      (Order order) => totalPrice += order.quantity * order.food.price,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart (${currentUser.cart.length})",
        ),
      ),
      body: ListView.separated(
        itemCount: currentUser.cart.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < currentUser.cart.length) {
            Order order = currentUser.cart[index];
            return _buildCartItem(order);
          }
          return Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Estimated Delivery Time: ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "25 min",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total cost: ",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$${totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 120.0,
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1.0,
            color: Colors.grey,
          );
        },
      ),
      bottomSheet: Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        decoration:
            BoxDecoration(color: Theme.of(context).primaryColor, boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, -1),
            blurRadius: 6.0,
          ),
        ]),
        child: Center(
          child: FlatButton(
            child: Text(
              "CHECKOUT",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
