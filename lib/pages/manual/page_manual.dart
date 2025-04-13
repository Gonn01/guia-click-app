import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_click/pages/manual/bloc/bloc_manuals.dart';
import 'package:guia_click/pages/manual/views/view_manual.dart';

@RoutePage()
class PageManual extends StatelessWidget {
  const PageManual({super.key, required this.manualId});
  final int manualId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocManual()..add(BlocManualEventInitialize()),
      child: const ViewManual(),
    );
  }
}
