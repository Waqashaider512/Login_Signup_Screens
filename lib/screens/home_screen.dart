import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isGridView = true;

  static const _items = [
    _HomeItem(
      title: 'Projects',
      subtitle: 'Turn your business idea into an app.',
      icon: Icons.folder_open_outlined,
      color: Color(0xFFE58A3A),
      action: _HomeAction.projects,
    ),
    _HomeItem(
      title: 'Contact me',
      subtitle: 'waqas151472@gmail.com',
      icon: Icons.email_outlined,
      color: Color(0xFF7765A8),
      url: 'mailto:waqas151472@gmail.com',
    ),
    _HomeItem(
      title: 'About me',
      subtitle: 'Developer, creator, problem solver',
      icon: Icons.person_outline_rounded,
      color: Color(0xFFBC5C62),
      action: _HomeAction.about,
    ),
  ];

  Future<void> _openLink(String url) async {
    try {
      final uri = Uri.parse(url);
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (opened || !mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open this link.')),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open your email application.')),
      );
    }
  }

  void _handleItemTap(_HomeItem item) {
    if (item.action == _HomeAction.projects) {
      _showProjects();
    } else if (item.action == _HomeAction.about) {
      _showAbout();
    } else if (item.url != null) {
      _openLink(item.url!);
    }
  }

  void _showProjects() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFFDF8F2),
      builder: (context) => const _ProjectsSheet(),
    );
  }

  void _showAbout() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFFFDF8F2),
      builder: (context) => const Padding(
        padding: EdgeInsets.fromLTRB(24, 18, 24, 32),
        child: _AboutSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F2),
        elevation: 0,
        leading: IconButton(
          tooltip: 'Go back',
          onPressed: null,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [const SizedBox(width: 8)],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 4, 24, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Malik Waqas Haider',
                style: theme.textTheme.displaySmall?.copyWith(
                  color: const Color(0xFF3C2B22),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3D9C0),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    ClipOval(
                      child: SizedBox(
                        height: 96,
                        width: 96,
                        child: Image.asset(
                          'assets/images/Waqas.png',
                          fit: BoxFit.cover,
                          alignment: const Alignment(0, -0.2),
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: const Color(0xFF3C2B22),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Software Engineer',
                            style: TextStyle(
                              color: Color(0xFF3C2B22),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Flutter Mobile Application Developer',
                            style: TextStyle(color: Color(0xFF765B48)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              Row(
                children: [
                  Text(
                    'Discover',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF3C2B22),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment(
                        value: true,
                        icon: Icon(Icons.grid_view_rounded, size: 18),
                      ),
                      ButtonSegment(
                        value: false,
                        icon: Icon(Icons.view_list_rounded, size: 18),
                      ),
                    ],
                    selected: {_isGridView},
                    onSelectionChanged: (selection) {
                      setState(() => _isGridView = selection.first);
                    },
                    showSelectedIcon: false,
                    style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      backgroundColor: WidgetStateProperty.resolveWith(
                        (states) => states.contains(WidgetState.selected)
                            ? const Color(0xFFF3D9C0)
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(child: _isGridView ? _buildGrid() : _buildList()),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text('Back'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      itemCount: _items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) => _buildItemCard(_items[index]),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      itemCount: _items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _buildItemCard(_items[index]),
    );
  }

  Widget _buildItemCard(_HomeItem item) {
    return InkWell(
      onTap: () => _handleItemTap(item),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFEFE3D7)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D3C2B22),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(item.icon, color: item.color),
            ),
            const SizedBox(height: 12),
            Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF3C2B22),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              item.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF8B7361), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeItem {
  const _HomeItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.url,
    this.action,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? url;
  final _HomeAction? action;
}

enum _HomeAction { projects, about }

class _ProjectsSheet extends StatelessWidget {
  const _ProjectsSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My projects',
              style: TextStyle(
                color: Color(0xFF3C2B22),
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'A selection of my software work',
              style: TextStyle(color: Color(0xFF8B7361)),
            ),
            const SizedBox(height: 16),
            const _ProjectTile(
              title: 'Pocket Ledger App',
              subtitle: 'A simple and practical personal finance manager.',
              icon: Icons.phone_android_rounded,
            ),
            const SizedBox(height: 10),
            const _ProjectTile(
              title: 'Sky Pulse App',
              subtitle: 'A clean weather experience for quick daily updates.',
              icon: Icons.cloud_outlined,
            ),
            const SizedBox(height: 10),
            const _ProjectTile(
              title: 'Job Tracker App',
              subtitle:
                  'Organize applications, interviews, and career progress.',
              icon: Icons.work_outline_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectTile extends StatelessWidget {
  const _ProjectTile({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      leading: const Icon(Icons.check_circle_outline, color: Color(0xFF3D8B88)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(icon, color: const Color(0xFFE58A3A)),
    );
  }
}

class _AboutSheet extends StatelessWidget {
  const _AboutSheet();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About me',
          style: TextStyle(
            color: Color(0xFF3C2B22),
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 18),
        Text(
          'I am Malik Waqas Haider from Pakistan.',
          style: TextStyle(color: Color(0xFF3C2B22), fontSize: 16, height: 1.5),
        ),
        SizedBox(height: 8),
        Text(
          'Software Engineer',
          style: TextStyle(
            color: Color(0xFF3C2B22),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Working as a Flutter Mobile Application Developer.',
          style: TextStyle(color: Color(0xFF8B7361), height: 1.5),
        ),
      ],
    );
  }
}
