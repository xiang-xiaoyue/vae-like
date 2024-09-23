import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/models/post.dart';
import 'package:trump/pages/discover/sub/shop/vm.dart';

// 购物车页面
class CartsPage extends StatelessWidget {
  const CartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ShopViewModel(),
      child: Consumer<ShopViewModel>(builder: (context, vm, _) {
        return Scaffold(
          appBar: CommonAppBar(
            title: "购物车",
            actions: [
              GestureDetector(
                onTap: null,
                child: Text(
                  "编辑",
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, idx) {
                  int goodsId = vm.carts.keys.toList()[idx];
                  Post goods = vm.goodsList.firstWhere((g) => g.id == goodsId);
                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            vm.selectGoods(goodsId);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                  width: 1, color: Colors.purpleAccent),
                            ),
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: vm.selectedGoodsList.contains(goodsId) ==
                                        true
                                    ? Colors.purpleAccent
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(goods.title),
                        SizedBox(width: 8),
                        Text(
                          "${goods.currencyCount}${goods.currencyType}",
                          style: TextStyle(color: Colors.red),
                        ),
                        Spacer(),
                        ToggleButtons(
                          isSelected: const [true, true, true],
                          borderWidth: 1,
                          children: [
                            GestureDetector(
                                onTap: () => vm.delCart(goodsId),
                                child: Icon(Icons.skip_previous)),
                            Text(
                              vm.carts[goodsId].toString(),
                              style: TextStyle(color: Colors.blue),
                            ),
                            GestureDetector(
                                onTap: () => vm.addCart(goodsId),
                                child: Icon(Icons.skip_next)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: vm.carts.length,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          vm.selectAll();
                        },
                        child: Text(
                          "全选",
                          style: TextStyle(
                            color:
                                vm.selectedGoodsList.length == vm.carts.length
                                    ? Colors.blue
                                    : Colors.black,
                          ),
                        ),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("合计"),
                          Text(
                            "${vm.totalPrice}金币",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      SizedBox(width: 8),
                      TrumpButton(
                          text: "结算",
                          height: 36,
                          backgroundColor:
                              vm.selectedGoodsList.length == vm.carts.length
                                  ? Colors.blue
                                  : Colors.grey.shade400,
                          textColor: Colors.white,
                          borderStyle: BorderStyle.none,
                          width: 80,
                          onTap: () {
                            vm.pay().then((msg) {
                              if (msg == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("支付成功"),
                                        backgroundColor: Colors.blue));
                                vm.getCarts();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(msg),
                                        backgroundColor: Colors.red));
                              }
                            });
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
