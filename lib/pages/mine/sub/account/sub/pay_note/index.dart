import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/exports.dart';
import 'package:trump/models/resp/models/pay_note.dart';
import 'package:trump/pages/mine/sub/account/sub/pay_note/vm.dart';

// 支付记录，Orders
class PayNotePage extends StatelessWidget {
  const PayNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PayNoteViewModel>(
      create: (context) => PayNoteViewModel(),
      child: Scaffold(
        appBar: CommonAppBar(title: "我的订单"),
        body: Consumer<PayNoteViewModel>(builder: (context, vm, _) {
          return ListView.builder(
            itemBuilder: (ctx, idx) {
              PayNote note = vm.notes[idx];
              return Container(
                height: 52,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    SizedBox(
                        width: 80,
                        child: Text(
                          note.postTitle.length > 5
                              ? note.postTitle.substring(0, 6)
                              : note.postTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    SizedBox(width: 16),
                    SizedBox(
                      width: 60,
                      child: Text(
                        "${note.currencyCount}${note.currencyType}",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Spacer(),
                    SizedBox(width: 80, child: Text("数量:${note.postCount}")),
                  ],
                ),
              );
            },
            itemCount: vm.notes.length,
          );
        }),
      ),
    );
  }
}
