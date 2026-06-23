import 'package:flutter/material.dart';
import '../core/theme/theme.dart';

class AppTableRow {
  const AppTableRow({required this.cells, this.selected = false});
  final List<Widget> cells;
  final bool selected;
}

/// Flutter equivalent of ui/table.tsx
class AppTable extends StatelessWidget {
  const AppTable({
    super.key,
    required this.headers,
    required this.rows,
    this.footer,
    this.caption,
  });

  final List<Widget> headers;
  final List<AppTableRow> rows;
  final List<Widget>? footer;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: const TableBorder(
              horizontalInside: BorderSide(color: AppColors.border),
            ),
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
                children: [
                  for (final header in headers)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s2,
                        vertical: AppSpacing.s2,
                      ),
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.labelMedium!,
                        child: header,
                      ),
                    ),
                ],
              ),
              for (final row in rows)
                TableRow(
                  decoration: BoxDecoration(
                    color: row.selected ? AppColors.muted : null,
                  ),
                  children: [
                    for (final cell in row.cells)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s2,
                          vertical: AppSpacing.s2,
                        ),
                        child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.bodyMedium!,
                          child: cell,
                        ),
                      ),
                  ],
                ),
              if (footer != null)
                TableRow(
                  decoration: BoxDecoration(
                    color: AppColors.muted.withOpacity(0.5),
                    border: const Border(top: BorderSide(color: AppColors.border)),
                  ),
                  children: [
                    for (final cell in footer!)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s2,
                          vertical: AppSpacing.s2,
                        ),
                        child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.labelMedium!,
                          child: cell,
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
        if (caption != null) ...[
          const SizedBox(height: AppSpacing.s2),
          Text(
            caption!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}
