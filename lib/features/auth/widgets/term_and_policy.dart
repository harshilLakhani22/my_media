
import 'package:flutter/cupertino.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';

class TermAndPolicy extends StatelessWidget {
  const TermAndPolicy({
    super.key,
    required this.onTermTap,
    required this.onPolicyTap,
  });

  final VoidCallback onTermTap;
  final VoidCallback onPolicyTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTermTap,
          child: const Text(
            MTexts.strTermOfServices,
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w300),
          ),
        ),
        const SizedBox(width: MSizes.lg),
        GestureDetector(
          onTap: onPolicyTap,
          child: const Text(
            MTexts.strPrivacyPolicy,
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
