import 'package:align_flutter_app/shared/constants/color_constants.dart';
import 'package:align_flutter_app/shared/utils/math_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationDot extends StatefulWidget {
  final List<BottomNavigationDotItem> items;
  final Color? activeColor;
  final Color? color;
  final Color? backgroundColor;
  final double? paddingBottomCircle;
  final int milliseconds;
  final int currentIndex;
  const BottomNavigationDot({
    required this.items,
    this.activeColor,
    this.color,
    this.backgroundColor,
    this.paddingBottomCircle,
    required this.milliseconds,
    Key? key,
    required this.currentIndex,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _BottomNavigationDotState();
}

class _BottomNavigationDotState extends State<BottomNavigationDot> {
  final GlobalKey _key = GlobalKey();
  double _numPositionBase = 0,
      _numDifferenceBase = 0,
      _positionLeftIndicatorDot = 0;
  int _indexSelected = 0;
  Color? _color, _activeColor;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: widget.backgroundColor,
        // height: getSize(76),
        // alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: getSize(16)),
        child: Stack(
          alignment: Alignment.center,
          key: _key,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: widget.paddingBottomCircle ?? 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _createNavigationIconButtonList(
                  widget.items.asMap(),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.milliseconds),
              curve: Curves.easeInOut,
              left: _positionLeftIndicatorDot,
              bottom: 0,
              child: CircleAvatar(
                radius: getSize(5),
                backgroundColor: _activeColor,
              ),
            ),
          ],
        ),
      );
  List<_NavigationIconButton> _createNavigationIconButtonList(
      Map<int, BottomNavigationDotItem> mapItem) {
    List<_NavigationIconButton> children = <_NavigationIconButton>[];
    mapItem.forEach(
      (index, item) => children.add(
        _NavigationIconButton(
          item.icon,
          (index == _indexSelected)
              ? _activeColor ?? ColorConstants.kPrimary
              : _color ?? ColorConstants.grey1,
          item.onTap,
          () {
            _changeOptionBottomBar(index);
          },
        ),
      ),
    );
    return children;
  }

  void _changeOptionBottomBar(int indexSelected) {
    if (indexSelected != _indexSelected) {
      setState(() {
        _positionLeftIndicatorDot =
            (_numPositionBase * (indexSelected + 1)) - _numDifferenceBase;
      });
      _indexSelected = indexSelected;
    }
  }

  _afterPage(_) {
    _color = widget.color ?? Colors.black45;
    _activeColor = widget.activeColor ?? Theme.of(context).primaryColor;
    final sizeBottomBar =
        (_key.currentContext!.findRenderObject() as RenderBox).size;
    print(sizeBottomBar);
    _numPositionBase = ((sizeBottomBar.width / widget.items.length));
    _numDifferenceBase = (_numPositionBase -
        (_numPositionBase /
            (widget.currentIndex == 0 || widget.currentIndex == 1
                ? 2.2
                : 2.0)) +
        2);
    setState(() {
      _positionLeftIndicatorDot = _numPositionBase - _numDifferenceBase;
    });
  }
}

class BottomNavigationDotItem {
  final String icon;
  final NavigationIconButtonTapCallback onTap;
  const BottomNavigationDotItem({required this.icon, required this.onTap});
}

typedef NavigationIconButtonTapCallback = void Function();

class _NavigationIconButton extends StatefulWidget {
  final String _icon;
  final Color _colorIcon;
  final NavigationIconButtonTapCallback _onTapInternalButton;
  final NavigationIconButtonTapCallback _onTapExternalButton;
  const _NavigationIconButton(this._icon, this._colorIcon,
      this._onTapInternalButton, this._onTapExternalButton,
      {Key? key})
      : super(key: key);
  @override
  _NavigationIconButtonState createState() => _NavigationIconButtonState();
}

class _NavigationIconButtonState extends State<_NavigationIconButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _sAnimation;
  double _opacityIcon = 1;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _sAnimation = Tween<double>(begin: 1, end: 0.93).animate(_controller!);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (_) {
          _controller?.forward();
          setState(() {
            _opacityIcon = 0.7;
          });
        },
        onTapUp: (_) {
          _controller?.reverse();
          setState(() {
            _opacityIcon = 1;
          });
        },
        onTapCancel: () {
          _controller?.reverse();
          setState(() {
            _opacityIcon = 1;
          });
        },
        onTap: () {
          widget._onTapInternalButton();
          widget._onTapExternalButton();
        },
        child: ScaleTransition(
          scale: _sAnimation!,
          child: AnimatedOpacity(
            opacity: _opacityIcon,
            duration: Duration(milliseconds: 200),
            child: SvgPicture.asset(
              widget._icon,
              color: widget._colorIcon,
            ),
          ),
        ),
      );
}
