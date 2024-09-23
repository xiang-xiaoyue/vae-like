import 'package:flutter/material.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/service/api.dart';

class ShopViewModel with ChangeNotifier {
  ShopViewModel() {
    getList();
    getCarts();
  }
  List<Post> goodsList = [];
  Map<int, int> carts = {};
  int goodsCountInCart = 0;
  List<int> selectedGoodsList = [];

  // 总价格（金币）
  int totalPrice = 0;

  // 选中商品或取消选中商品
  void selectGoods(int id) {
    if (selectedGoodsList.contains(id) == true) {
      selectedGoodsList.remove(id);
    } else {
      selectedGoodsList.add(id);
    }
    calculateTotalPrice();
    notifyListeners();
  }

  // 计算总价格（金币）todo:应当支持其他类型倾向
  void calculateTotalPrice() {
    totalPrice = 0;
    for (var g in selectedGoodsList) {
      Post goods = goodsList.firstWhere((i) => i.id == g);
      totalPrice += goods.currencyCount * (carts[g] ?? 0);
    }
  }

  // 全选购物车的商品
  void selectAll() {
    if (selectedGoodsList.length == carts.length) {
      selectedGoodsList.clear();
    } else {
      selectedGoodsList = carts.keys.toList();
    }
    calculateTotalPrice();
    notifyListeners();
  }

  // 加载商品列表
  Future getList() async {
    ListResp listResp =
        await Api.instance.getPostList(postType: Constants.postTypeGoods);
    goodsList.clear();
    listResp.list?.forEach((i) {
      goodsList.add(Post.fromJson(i));
    });
    notifyListeners();
  }

  // 加载购物车
  Future getCarts() async {
    ListResp listResp =
        await Api.instance.getCollectingPostList(type: Constants.postTypeGoods);
    carts.clear();
    listResp.list?.forEach((i) {
      goodsCountInCart++;
      Post goods = Post.fromJson(i);
      carts[goods.id] = (carts[goods.id] ?? 0) + 1;
    });
    notifyListeners();
  }

  // 加入购物车
  Future addCart(int id) async {
    bool success = await Api.instance.collectPost(id);
    if (success == true) {
      carts[id] = (carts[id] ?? 0) + 1;
      goodsCountInCart++;
      calculateTotalPrice();
    }
    notifyListeners();
  }

  // 从购物车移除一件
  Future delCart(int id) async {
    bool success = await Api.instance.cancelCollectPost(id);
    if (success == true) {
      if (carts[id] == 1) {
        carts.remove(id);
      } else {
        carts[id] = carts[id]! - 1;
      }
      goodsCountInCart--;
      calculateTotalPrice();
      notifyListeners();
    }
  }

  // 从购物车将某件商品全部移除
  Future removeGoods(int id) async {
    bool success = await Api.instance.cancelCollectPost(id, removeAll: true);
    if (success == true) {
      goodsCountInCart -= carts[id] ?? 0;
      calculateTotalPrice();
      notifyListeners();
    }
  }

  // 支付
  Future<String> pay() async {
    Map<String, int> goodsList = {};
    for (var i in selectedGoodsList) {
      goodsList[i.toString()] = carts[i] ?? 0;
    }
    String msg = await Api.instance.pay(goodsList);
    if (msg == "") {
      //支付成功
      for (var i in selectedGoodsList) {
        removeGoods(i);
      }
    }
    notifyListeners();
    return msg;
  }
}
