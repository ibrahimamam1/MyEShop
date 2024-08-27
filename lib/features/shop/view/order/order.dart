import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/features/shop/view/order/widgets/order_list_items.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: SAppBar(
          title: Text('My Orders',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: AppOrderListItems(),
      ),
    );
  }
}
