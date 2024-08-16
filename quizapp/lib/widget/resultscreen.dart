import 'package:flutter/material.dart';

class ResultScreenWidget extends StatefulWidget {
  const ResultScreenWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitleText,
    required this.text,
    this.divider = false,
    this.subtitle = false,
  });
  final IconData icon;
  final bool divider;
  final String title;
  final String subtitleText;
  final bool subtitle;
  final String text;

  @override
  State<ResultScreenWidget> createState() => _ResultScreenWidgetState();
}

class _ResultScreenWidgetState extends State<ResultScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          width: double.infinity,

          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  // border: Border.all(color: Colors.black),
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                child: Icon(
                  widget.icon,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    widget.subtitle
                        ? Text(
                            widget.subtitleText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 14,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    widget.text,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              )
            ],
          ),
        ),
        widget.divider
            ? Divider(color: Theme.of(context).dividerColor)
            : const SizedBox(),
      ],
    );
  }
}
