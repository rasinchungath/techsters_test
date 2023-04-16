import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'custom_button.dart';

class TabViewLeave extends StatelessWidget {
  const TabViewLeave({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: 560,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Apply leave',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Date',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    style: textFieldStyle,
                    keyboardType: TextInputType.datetime,
                    decoration: dateFieldDecoration.copyWith(
                      hintText: 'From ...',
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    style: textFieldStyle,
                    keyboardType: TextInputType.datetime,
                    decoration: dateFieldDecoration.copyWith(
                      hintText: 'To Date',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.shade200,
              ),
              child: TextFormField(
                decoration: reasonFieldDecoration,
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            CustomButton(
              text: 'Apply',
              height: 35,
              width: double.infinity,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
