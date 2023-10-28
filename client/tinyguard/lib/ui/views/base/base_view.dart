import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinyguard/ui/views/base/responsive.dart';
import 'package:tinyguard/view_models.dart/base_view_model.dart';

class BaseView<VM extends BaseViewModel?> extends StatelessWidget {
  final Color? backgroundColor;
  final Widget Function(BuildContext)? bottomNavigationBuilder;
  final VM? viewModel;
  final Widget Function(BuildContext) mobileBuilder;
  final Widget Function(BuildContext)? desktopBuilder;
  final Widget Function(BuildContext)? tabletBuilder;
  final bool resizeToAvoidBottomInset;

  const BaseView({
    super.key,
    this.viewModel,
    this.backgroundColor,
    this.bottomNavigationBuilder,
    required this.mobileBuilder,
    this.desktopBuilder,
    this.tabletBuilder,
    this.resizeToAvoidBottomInset = false,
  });

  @override
  Widget build(BuildContext context) {
    if (viewModel != null) {
      return ChangeNotifierProvider.value(
        value: viewModel,
        builder: (ctx, _) {
          return _buildBody(ctx);
        },
      );
    } else {
      return _buildBody(context);
    }
  }

  Widget _buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: OrientationBuilder(
          builder: (ctx, __) {
            return Responsive(
              mobile: mobileBuilder.call(ctx),
              tablet: tabletBuilder?.call(ctx),
            );
          },
        ),
        bottomNavigationBar: bottomNavigationBuilder?.call(context),
        backgroundColor: backgroundColor,
      ),
    );
  }
}