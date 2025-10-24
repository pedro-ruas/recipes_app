import 'package:flutter/material.dart';

class NavWidget extends StatelessWidget {
  const NavWidget({super.key, required this.navItem});

  final NavItem navItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        navItem.icon,
        size: 26,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      title: Text(
        navItem.title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 24,
        ),
      ),
      onTap: () {
        navItem.onTap();
      },
    );
  }
}

class NavItem {
  const NavItem(this.icon, this.title, this.onTap);

  final IconData icon;
  final String title;
  final Function onTap;
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  List<NavItem> get navItems => [
    NavItem(Icons.restaurant, "Meals", () {
      onSelectScreen("meals");
    }),
    NavItem(Icons.settings, "filters", () {
      onSelectScreen("filters");
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.primaryContainer.withAlpha(200),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              spacing: 16,
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  "Cooking up!",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          ...navItems.map((item) => NavWidget(navItem: item)),
        ],
      ),
    );
  }
}
