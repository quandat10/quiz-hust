import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(child: ShimerLayout(), baseColor: Colors.grey[300], highlightColor: Colors.white54),
    );
  }
}
class ShimerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 64, 64, .4),
    );
  }
}





