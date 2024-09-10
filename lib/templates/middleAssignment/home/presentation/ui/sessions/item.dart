import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get_it/get_it.dart';

import '../../../../domain/shower_session.dart';
import '../../../../ui/theme/images.dart';
import '../../../../ui/theme/theme.dart';

const _showerIconSize = 32.0;
const _clockIconSize = 16.0;

class SessionItem extends StatelessWidget {
  final ShowerSession item;
  final _theme = GetIt.instance<AppTheme>();

  SessionItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) => Card(
    color: _theme.colors.background.item,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_theme.dimensions.radius.small)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: _theme.dimensions.padding.small),

        Image(
          image: AssetImage(AppImages.load('shower.png')),
          width: _showerIconSize,
          height: _showerIconSize,
        ),

        SizedBox(width: _theme.dimensions.padding.medium),

        _itemMeta(context),
      ],
    ),
  );

  Widget _itemMeta(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final datetime = DateTime.parse(item.startTimestamp);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: _theme.dimensions.padding.small),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage(AppImages.load('ic_clock.png')),
              width: _clockIconSize,
              height: _clockIconSize,
            ),

            SizedBox(width: _theme.dimensions.padding.small),

            Text(
              '${datetime.hour}:${datetime.day} (${datetime.day}.${datetime.month}.${datetime.year})',
              style: _theme.typography.body.copyWith(
                color: _theme.colors.text.onItem,
              ),
            )
          ],
        ),

        SizedBox(height: _theme.dimensions.padding.extraSmall),

        Text(
          '${strings.shower_home_item_duration}: ${item.totalDuration}',
          style: _theme.typography.caption.copyWith(
            color: _theme.colors.text.onItem,
          ),
        ),

        SizedBox(height: _theme.dimensions.padding.extraSmall),

        Text(
          '${strings.shower_home_item_phases}: ${item.phases}',
          style: _theme.typography.caption.copyWith(
            color: _theme.colors.text.onItem,
          ),
        ),

        SizedBox(height: _theme.dimensions.padding.small),
      ],
    );
  }
}
