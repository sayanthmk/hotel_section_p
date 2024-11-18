import 'package:flutter/material.dart';
import 'package:hotel_side/views/registration_page/poilcy_page/widgets/policy_widgets.dart';

import 'widgets/policy_list.dart';

class PoliciesPage extends StatelessWidget {
  const PoliciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF5F9FF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      PolicyHeader(),
                      SizedBox(height: 24),
                      PolicyList(),
                    ],
                  ),
                ),
              ),
            ),
            BottomActionButton(),
          ],
        ),
      ),
    );
  }
}
