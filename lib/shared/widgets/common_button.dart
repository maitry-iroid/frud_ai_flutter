// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// class CommonButton extends StatelessWidget {
//   final double borderRadius;
//   final double? width;
//   final double height;
//   final Gradient? gradient;
//   final VoidCallback? onPressed;
//   final Widget child;
//   final List<BoxShadow>? shadows;
//   final Color? backgroundColor; //Color(0xff8BC75A)

//   const CommonButton({
//     Key? key,
//     required this.onPressed,
//     required this.child,
//     this.borderRadius = 16,
//     this.width,
//     this.height = 50.0,
//     this.shadows,
//     this.gradient,
//     this.backgroundColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final borderRadius = this.borderRadius ?? BorderRadius.circular(14);
//     return Container(
//       width: width ?? Get.width,
//       height: height,
//       alignment: Alignment.center,
//       decoration: ShapeDecoration(
//         color: backgroundColor ?? ColorConstants.kPrimary,
//         shape: SmoothRectangleBorder(
//           borderRadius: SmoothBorderRadius.all(
//             SmoothRadius(
//               cornerRadius: getSize(borderRadius),
//               cornerSmoothing: 1,
//             ),
//           ),
//         ),
//         shadows: shadows ??
//             [
//               BoxShadow(
//                 offset: Offset(0, 10),
//                 blurRadius: 30,
//                 color: ColorConstants.buttonShadowColor.withOpacity(0.20),
//               ),
//             ],
//       ),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           primary: Colors.transparent,
//           shadowColor: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(
//               getSize(borderRadius),
//             ),
//           ),
//         ),
//         child: child,
//       ),
//     );
//   }
// }
