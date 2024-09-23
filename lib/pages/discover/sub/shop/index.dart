import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/components/toast.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/pages/discover/sub/shop/vm.dart';
import 'package:trump/pages/mine/vm.dart';

// 商城页面
class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShopViewModel>(
      create: (context) => ShopViewModel(),
      child: Consumer2<ShopViewModel, CurrentUserViewModel>(
          builder: (context, vm, cur, _) {
        return Scaffold(
          appBar: CommonAppBar(
            title: "商城",
            actions: [
              GestureDetector(
                onTap: () {
                  if (cur.isLoggedIn) {
                    context.pushNamed("carts");
                  } else {
                    context.showToast("未登录，请登录后操作");
                    return;
                  }
                },
                child: Badge(
                  backgroundColor: Colors.red,
                  label: Text("${vm.goodsCountInCart}"),
                  isLabelVisible: vm.carts.isNotEmpty ? true : false,
                  textStyle: TextStyle(fontSize: 8, color: Colors.red),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  largeSize: 14,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 28,
                    color: Colors.indigo,
                  ),
                ),
              ),
            ],
          ),
          body: ListView.separated(
            padding: EdgeInsets.only(top: 8, bottom: 32),
            separatorBuilder: (ctx, idx) {
              return SizedBox(height: 2);
            },
            itemBuilder: (ctx, idx) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                color: Colors.white,
                height: 42,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(vm.goodsList[idx].title),
                    TrumpButton(
                      height: 36,
                      text: "加入购物车",
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      backgroundColor: Colors.blue.shade400,
                      textColor: Colors.white,
                      borderStyle: BorderStyle.none,
                      onTap: () {
                        if (cur.isLoggedIn == true) {
                          return vm.addCart(vm.goodsList[idx].id);
                        } else {
                          context.showToast("未登录，请登录后操作");
                        }
                      },
                    ),
                  ],
                ),
              );
            },
            itemCount: vm.goodsList.length,
          ),
        );
      }),
    );
  }
}

// todo: 当前未使用
class _GoodsCard extends StatelessWidget {
  final Post goods;
  const _GoodsCard({
    super.key,
    required this.goods,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed("goods_detail",
            queryParameters: {"id": goods.id.toString()});
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              goods.posterUrl,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (ctx, e, st) {
                return Container(
                    height: 180,
                    color: Colors.grey.shade300,
                    child: Center(child: Text("图片加载失败")));
              },
            ),
            SizedBox(height: 4),
            Row(
              children: [
                TrumpButton(
                  text: goods.currencyType,
                  borderColor: Colors.purpleAccent,
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                  margin: EdgeInsets.only(right: 8),
                  borderRadius: 4,
                  textSize: 10,
                  textColor: Colors.purpleAccent,
                ),
                Text(goods.title),
              ],
            ),
            SizedBox(height: 8),
            Text(
              goods.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text(
                    "${goods.currencyCount}${goods.currencyType}",
                    style: TextStyle(color: Colors.red),
                  ),
                  Spacer(),
                  IconAndText(
                      icon: Icons.comment_outlined,
                      text: "${goods.commentCount}"),
                  IconAndText(
                      icon: Icons.thumb_up_outlined,
                      text: "${goods.likeCount}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
