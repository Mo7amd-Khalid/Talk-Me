import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_me/core/constant/app_assets.dart';
import 'package:talk_me/core/di/di.dart';

import '../setup_cubit/setup_contract.dart';
import '../setup_cubit/setup_cubit.dart';

class LanguageSwitch extends StatelessWidget {
  LanguageSwitch({super.key});
  final SetupCubit cubit = getIt();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetupCubit, SetupState>(
      builder: (_, state) => AnimatedToggleSwitch.rolling(
          current: state.language,
          values:
          [
            "en",
            "ar"
          ],
          onChanged: (value)
          {
          cubit.doAction(ChangeLanguage(value));
          },
          iconBuilder: (value, selected) {
            if(value == "en") {
              return Image.asset(AppImages.en);
            }
            else
              {
                return Image.asset(AppImages.ar);
              }
          },
        borderWidth: 1,
        padding: EdgeInsets.zero,
        height: MediaQuery.sizeOf(context).height*0.04,
        indicatorSize: Size.fromWidth(40),
        style: ToggleStyle(
          indicatorColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.surface,
          borderColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
