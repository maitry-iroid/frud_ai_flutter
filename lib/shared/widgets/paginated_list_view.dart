import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PaginatedListView extends StatelessWidget {
  final int pageElementCount;
  final Widget child;
  final Widget noDataWidget;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  ///An common list view with pagination functionalities
  PaginatedListView({
    Key? key,
    required this.pageElementCount,
    required this.onRefresh,
    required this.onLoading,
    required this.child,
    required this.noDataWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      header: WaterDropHeader(),
      enablePullDown: true,
      enablePullUp: pageElementCount > 0,
      controller: refreshController,
      onRefresh: () {
        onRefreshData();
      },
      onLoading: () {
        onLoadMoreData();
      },
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("release to load more");
          } else {
            body = Text("No more Data");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      child: pageElementCount > 0
          ? child
          : Center(
              child: noDataWidget,
            ),
    );
  }

  onRefreshData() {
    onRefresh();
    refreshController.refreshCompleted();
  }

  onLoadMoreData() {
    onLoading();
    refreshController.loadComplete();
  }
}
