// ignore_for_file: prefer_const_constructors_in_immutables


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/models/medal.dart';
import 'package:trump/pages/mine/sub/medal/vm.dart';
import 'package:trump/pages/notice/export.dart';

// 勋章页面
class MineMedalsPage extends StatefulWidget {
  const MineMedalsPage({super.key});

  @override
  State<MineMedalsPage> createState() => _MineMedalsPageState();
}

class _MineMedalsPageState extends State<MineMedalsPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 4,
      animationDuration: Duration.zero,
    );
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MedalViewModel>(
      create: (context) => MedalViewModel(),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          automaticallyImplyLeading: false,
          leading: Align(
            alignment: Alignment.topCenter,
            child: GoBackLeading(color: Colors.white, iconSize: 32),
          ),
          toolbarHeight: 140,
          leadingWidth: 16,
          titleSpacing: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "我的勋章墙",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 4),
              Consumer<MedalViewModel>(builder: (context, vm, _) {
                return Text(
                  "已拥有${vm.medals.where((i) => i.isHolding == true).length}枚勋章，共${vm.medals.length}枚",
                  style: TextStyle(fontSize: 14, color: Color(0xffb0bff8)),
                );
              }),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(54),
            child: Container(
              decoration: BoxDecoration(
                  //color: Colors.purple,
                  color: Color(0xfff6f7fb),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: TabBar(
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.all(0),
                dividerHeight: 0,
                indicator: _CustomIndcator(
                    width: (MediaQuery.sizeOf(context).width - 64) / 4,
                    height: 54,
                    radius: 12),
                unselectedLabelColor: Color(0xff8f9298),
                labelColor: Colors.blue,
                labelStyle: TextStyle(fontSize: 18),
                unselectedLabelStyle: TextStyle(fontSize: 16),
                tabs: const [
                  Tab(text: "勋章1"),
                  Tab(text: "勋章2"),
                  Tab(text: "勋章3"),
                  Tab(text: "勋章4"),
                ],
              ),
            ),
          ),
          backgroundColor: Color(0xff3d5ee1),
          flexibleSpace: FlexibleSpaceBar(
              // background: Image.asset(
              //   "assets/images/3.jpg",
              //   fit: BoxFit.cover,
              // ),
              ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Consumer<MedalViewModel>(builder: (context, vm, _) {
            return TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                GridView.builder(
                  itemCount: vm.medals.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 12 / 10,
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (ctx, idx) {
                    return _ToGrey(
                      isGrey: (vm.medals[idx].isHolding == true ||
                              vm.medals[idx].hasSufficientPower == true)
                          ? false
                          : true,
                      child: MedalSimpleCard(
                          medal: vm.medals[idx],
                          onTap: (medal) {
                            bool power = medal.hasSufficientPower;
                            bool isWearing = medal.isWearing;
                            bool isHolding = medal.isHolding;
                            if (power == true && isHolding == false) {
                              // 兑换勋章
                              vm.gainMedal(medal.id).then((_) {
                                context.pop();
                              });
                            }
                            if ((isHolding == true && isWearing == false) ||
                                (isWearing == true)) {
                              // 佩戴或取消佩戴
                              vm.wearMedal(medal).then((_) {
                                context.pop();
                              });
                            }
                          }),
                    );
                  },
                ),
                Center(child: NoMore()),
                Center(child: NoMore()),
                Center(child: NoMore()),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class MedalSimpleCard extends StatelessWidget {
  final Medal medal;
  final Function onTap;
  const MedalSimpleCard({
    super.key,
    required this.medal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return Dialog(
                  //insetPadding: EdgeInsets.only(top: 20),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(top: 32, bottom: 0),
                    height: 400,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _ToGrey(
                          isGrey: (medal.isHolding == true ||
                                  medal.hasSufficientPower == true)
                              ? false
                              : true,
                          child: Image.network(
                            medal.imgUrl,
                            colorBlendMode: BlendMode.luminosity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 32),
                        Text(
                          medal.name,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "- 未获得(${medal.doneCount}/${medal.requireDoneCount}) -",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            medal.info,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        Spacer(),
                        TrumpButton(
                          // text: medal.hasSufficientPower == false
                          //     ? "未获得"
                          //     : (medal.hasSufficientPower == true &&
                          //             medal.isHolding == false)
                          //         ? "获得勋章"
                          //         : (medal.isHolding == true &&
                          //                 medal.isWearing == false)
                          //             ? "设置为挂件"
                          //             : "取消",
                          //text: ?,
                          text: (medal.isWearing == true)
                              ? "取消"
                              : (medal.isHolding == true &&
                                      medal.isWearing == false)
                                  ? "设置为挂件"
                                  : "未获得",
                          fontWeight: FontWeight.w500,
                          backgroundColor: ((medal.hasSufficientPower == true &&
                                      medal.isHolding == false) ||
                                  (medal.isHolding == true &&
                                      medal.isWearing == false))
                              ? Colors.blue
                              : Colors.grey.shade500,
                          textColor: Colors.white,
                          borderRadius: 0,
                          borderStyle: BorderStyle.none,
                          textSize: 20,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          onTap: () {
                            onTap(medal);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              });
            });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0, color: Colors.transparent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(medal.imgUrl),
            Text(medal.name),
          ],
        ),
      ),
    );
  }
}

class _ToGrey extends StatelessWidget {
  final Widget child;
  final bool isGrey;
  const _ToGrey({
    super.key,
    required this.child,
    this.isGrey = true,
  });

  @override
  Widget build(BuildContext context) {
    return isGrey == true
        ? ColorFiltered(
            colorFilter: ColorFilter.matrix(
              <double>[
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0.2126,
                0.7152,
                0.0722,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
              ],
            ),
            child: child,
          )
        : child;
  }
}

class _CustomIndcator extends Decoration {
  final double width;
  final double height;
  final double radius;

  _CustomIndcator({
    required this.width,
    required this.height,
    this.radius = 12,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomBoxPainter(this, onChanged, width, height, radius);
  }
}

class _CustomBoxPainter extends BoxPainter {
  final _CustomIndcator decoration;
  final double width;
  final double height;
  final double radius;

  _CustomBoxPainter(
    this.decoration,
    VoidCallback? onChanged,
    this.width,
    this.height,
    this.radius,
  ) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final size = configuration.size;
    final newOffset = Offset(
      offset.dx + (size!.width - width) / 2,
      (size.height) - height,
    );
    final Rect rect = newOffset & Size(width, height);
    final Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      //RRect.fromRectAndRadius(rect, Radius.circular(radius)),
      RRect.fromRectAndCorners(rect,
          topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
      paint,
    );
  }
}
