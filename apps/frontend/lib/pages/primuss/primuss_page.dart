import 'package:flutter/material.dart';
import 'package:organisation_app/shared/integrated_browser.dart';

class PrimussPage extends StatefulWidget {
  const PrimussPage({super.key});

  @override
  State<PrimussPage> createState() => _PrimussPageState();
}

class _PrimussPageState extends State<PrimussPage> {
  @override
  Widget build(BuildContext context) {
    return const IntegratedBrowser(
        title: "Primuss", startUrl: 'https://www.primuss.de/portal-fhm');
  }
}
