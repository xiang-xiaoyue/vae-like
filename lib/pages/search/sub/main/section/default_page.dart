import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/pages/search/components/search_history_item.dart';
import 'package:trump/pages/search/components/search_page_subject_item.dart';
import 'package:trump/pages/search/sub/main/vm.dart';

class SearchMainDefaultPage extends StatelessWidget {
  final Function toResult;
  const SearchMainDefaultPage({super.key, required this.toResult});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Consumer<MainSearchViewModel>(builder: (context, vm, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SearchHistoryWrap(toResult: toResult), //搜索历史
            _PostThreadTypeList(), //帖子类型列表,todo: 在新界面展示“最新”和“最热”，这个“最热”是什么？
            _LatestSubjectList(), // 最新话题列表，50个
          ],
        );
      }),
    );
  }
}

// 搜索页面的历史记录
class _SearchHistoryWrap extends StatefulWidget {
  final Function toResult;
  const _SearchHistoryWrap({
    super.key,
    required this.toResult,
  });

  @override
  State<_SearchHistoryWrap> createState() => _SearchHistoryWrapState();
}

class _SearchHistoryWrapState extends State<_SearchHistoryWrap> {
  MainSearchViewModel vm = MainSearchViewModel();
  @override
  Widget build(BuildContext context) {
    return vm.showSearchHistory == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SearchHistoryTitle(onTap: () => vm.historyList = []),
              Row(
                children: vm.historyList.map((itm) {
                  return Container(
                    margin: const EdgeInsets.only(right: 4),
                    child: GestureDetector(
                      onTap: () {
                        // vm.changeKeyword(itm);
                        // vm.showResult();
                        vm.changeKeyword(itm);
                        widget.toResult();
                        setState(() {});
                      },
                      child: SearchHistoryItem(text: itm),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          )
        : const SizedBox();
  }
}

class _SearchHistoryTitle extends StatelessWidget {
  final VoidCallback onTap;
  const _SearchHistoryTitle({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: AppDoubleText(left: "历史记录", right: "清空", onTap: onTap),
    );
  }
}

class _PostThreadTypeList extends StatelessWidget {
  const _PostThreadTypeList();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppDoubleText(left: "帖子类型", right: ""),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _PostTypeItem(
                text: "视频",
                iconData: Icons.videocam,
                type: Constants.postSubTypeVideo),
            _PostTypeItem(
                text: "长文",
                iconData: Icons.text_fields,
                type: Constants.postSubTypeLongText),
            _PostTypeItem(
                text: "图文",
                iconData: Icons.picture_in_picture,
                type: Constants.postSubTypeTextWithImages),
            _PostTypeItem(
                text: "文字",
                iconData: Icons.textsms,
                type: Constants.postSubTypeShortText),
            _PostTypeItem(
                text: "音频",
                iconData: Icons.voicemail,
                type: Constants.postSubTypeVoice),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

// 帖子类型：视频、图文、长文、文字、语音
class _PostTypeItem extends StatelessWidget {
  final String text;
  final IconData iconData;
  final String type;

  const _PostTypeItem({
    required this.text,
    required this.iconData,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    var decoration = BoxDecoration(
      color: Colors.grey.withAlpha(300),
      borderRadius: BorderRadius.circular(8),
    );
    return GestureDetector(
      onTap: () {
        context.pushNamed("search_results", queryParameters: {"type": type});
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: decoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(iconData, color: Colors.grey),
            Text(text),
          ],
        ),
      ),
    );
  }
}

class _LatestSubjectList extends StatefulWidget {
  const _LatestSubjectList();

  @override
  State<_LatestSubjectList> createState() => _LatestSubjectListState();
}

class _LatestSubjectListState extends State<_LatestSubjectList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppDoubleText(left: "最新话题", right: ""),
        const SizedBox(height: 10),
        Consumer<MainSearchViewModel>(builder: (context, vm, child) {
          return Wrap(
            spacing: 16,
            runSpacing: 8,
            children: vm.latestSubjectList.map((item) {
              return SearchPageSubjectItem(
                  text: item.name, id: item.id.toString());
            }).toList(),
          );
        }),
      ],
    );
  }
}
