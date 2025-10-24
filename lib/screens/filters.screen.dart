import 'package:flutter/material.dart';

const Map<FilterType, bool> kInitialFilters = {
  FilterType.gluten: false,
  FilterType.lactose: false,
  FilterType.vegan: false,
  FilterType.vegetarian: false,
};

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, this.initialFilters = kInitialFilters});

  final Map<FilterType, bool> initialFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  Map<FilterType, bool> _activeFilters = kInitialFilters;

  @override
  void initState() {
    super.initState();
    _activeFilters = Map.from(widget.initialFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Filters")),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;

          Navigator.of(context).pop(_activeFilters);
        },

        child: Column(
          children: filters
              .map(
                (filter) => FilterWidget(
                  title: filter.title,
                  subtitle: filter.subtitle,
                  value: _activeFilters[filter.filterKey]!,
                  onTap: (bool isChecked) {
                    setState(() {
                      _activeFilters[filter.filterKey] = isChecked;
                    });
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool value;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: (isChecked) {
        onTap(isChecked);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      activeThumbColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 32, right: 24),
    );
  }
}

enum FilterType { gluten, lactose, vegetarian, vegan }

class Filter {
  const Filter(this.title, this.subtitle, this.filterKey);

  final String title;
  final String subtitle;
  final FilterType filterKey;
}

List<Filter> filters = [
  Filter("Gluten-free", "Only display gluten-free meals", FilterType.gluten),
  Filter("Lactose-free", "Only display lactose-free meals", FilterType.lactose),
  Filter("Vegetarian", "Only display vegetarian meals", FilterType.vegetarian),
  Filter("Vegan", "Only display vegan meals", FilterType.vegan),
];
