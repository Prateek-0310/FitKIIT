import 'package:flutter/material.dart';

class AnnouncementItem {
  final String title;
  final String body;
  final String date;
  final String category;

  const AnnouncementItem({
    required this.title,
    required this.body,
    required this.date,
    required this.category,
  });
}

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  final List<AnnouncementItem> _announcements = const [
    AnnouncementItem(
      title: 'Janmashtami Holiday Closure',
      body:
          'The University Central Gym will remain closed on 25th August on account of Janmashtami. Regular sessions resume the following day.',
      date: '20 Aug 2026',
      category: 'HOLIDAY',
    ),
    AnnouncementItem(
      title: 'Morning Slot Timings Updated',
      body:
          'Morning slots will now start at 5:30 AM instead of 6:00 AM to accommodate early birds before academic sessions.',
      date: '15 Aug 2026',
      category: 'TIMING',
    ),
    AnnouncementItem(
      title: 'Leg Extension Machine Servicing',
      body:
          'Machine #4 is currently undergoing cable maintenance and will be available by tomorrow evening.',
      date: '12 Aug 2026',
      category: 'MAINTENANCE',
    ),
  ];

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'HOLIDAY':
        return Colors.orangeAccent;
      case 'TIMING':
        return const Color(0xFF00C853);
      case 'MAINTENANCE':
        return Colors.lightBlueAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notices & Announcements'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _announcements.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notice = _announcements[index];
          final badgeColor = _getCategoryColor(notice.category);

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Color(0xFF262D38)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          notice.category,
                          style: TextStyle(
                            color: badgeColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        notice.date,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    notice.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notice.body,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
