import 'package:flutter/material.dart';

class SettingItemCard extends StatefulWidget {
  const SettingItemCard({
    super.key,
    required this.column,
    required this.title,
  });
  final Column column;
  final String title;

  @override
  State<SettingItemCard> createState() => _SettingItemCardState();
}

class _SettingItemCardState extends State<SettingItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            padding: const EdgeInsets.only(top: 3),
            width: double.infinity,
            decoration: BoxDecoration(
              // color: Theme.of(context).secondaryHeaderColor,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: Theme.of(context).dividerColor, width: 0.5),
            ),
            child: Column(
              children: [widget.column],
            ),
          ),
        ],
      ),
    );
  }
}
