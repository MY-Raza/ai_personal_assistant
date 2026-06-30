import 'package:flutter/material.dart';
import '../core/theme/theme.dart';
import '../ui/shared_widgets.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  static const _hourly = [
    {'time': 'Now', 'temp': 72, 'icon': '☀️'},
    {'time': '1PM', 'temp': 74, 'icon': '☀️'},
    {'time': '2PM', 'temp': 75, 'icon': '🌤'},
    {'time': '3PM', 'temp': 73, 'icon': '⛅'},
    {'time': '4PM', 'temp': 70, 'icon': '🌤'},
    {'time': '5PM', 'temp': 68, 'icon': '☀️'},
  ];

  static const _weekly = [
    {'day': 'Today', 'high': 75, 'low': 58, 'icon': '☀️', 'cond': 'Sunny'},
    {'day': 'Tue', 'high': 68, 'low': 54, 'icon': '🌤', 'cond': 'Partly Cloudy'},
    {'day': 'Wed', 'high': 61, 'low': 50, 'icon': '🌧', 'cond': 'Rain'},
    {'day': 'Thu', 'high': 65, 'low': 52, 'icon': '⛅', 'cond': 'Overcast'},
    {'day': 'Fri', 'high': 70, 'low': 56, 'icon': '🌤', 'cond': 'Partly Cloudy'},
    {'day': 'Sat', 'high': 76, 'low': 59, 'icon': '☀️', 'cond': 'Sunny'},
    {'day': 'Sun', 'high': 78, 'low': 61, 'icon': '☀️', 'cond': 'Sunny'},
  ];

  static const _suggestions = [
    _Suggestion(
      icon: Icons.water_drop_outlined,
      iconColor: Color(0xFF60A5FA),
      text: 'Rain expected Wednesday. Schedule outdoor tasks today or Friday.',
      bg: Color(0x1A3B82F6),
      border: Color(0x333B82F6),
    ),
    _Suggestion(
      icon: Icons.wb_sunny_outlined,
      iconColor: Color(0xFFFBBF24),
      text: 'Great weather for outdoor exercise today and this weekend.',
      bg: Color(0x1AF59E0B),
      border: Color(0x33F59E0B),
    ),
    _Suggestion(
      icon: Icons.coffee_outlined,
      iconColor: Color(0xFF2DD4BF),
      text: 'Perfect morning for a walk. Temperature peaks at 75°F this afternoon.',
      bg: Color(0x1A14B8A6),
      border: Color(0x3314B8A6),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildHourlyCard(),
                  const SizedBox(height: 16),
                  _buildWeeklyCard(),
                  const SizedBox(height: 16),
                  _buildSuggestions(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1E3A5F), Color(0xFF0F172A)],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, color: Color(0xFF94A3B8), size: 14),
              SizedBox(width: 6),
              Text('San Francisco, CA', style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 14, fontWeight: FontWeight.w500)),
              SizedBox(width: 6),
              Icon(Icons.navigation_outlined, color: Color(0xFF818CF8), size: 12),
            ],
          ),
          const SizedBox(height: 8),
          const Text('72°', style: TextStyle(color: Colors.white, fontSize: 72, fontWeight: FontWeight.w900, height: 1)),
          const SizedBox(height: 4),
          const Text('Mostly Sunny', style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 20, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          const Text('Feels like 70° · H:75° L:58°', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStat(Icons.air, 'Wind', '8 mph'),
              const SizedBox(width: 24),
              _buildStat(Icons.water_drop_outlined, 'Humidity', '52%'),
              const SizedBox(width: 24),
              _buildStat(Icons.thermostat_outlined, 'UV Index', '6 High'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF94A3B8), size: 14),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildHourlyCard() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'HOURLY FORECAST',
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.2),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 86,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _hourly.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final h = _hourly[i];
                final isNow = h['time'] == 'Now';
                return Container(
                  width: 56,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isNow ? const Color(0x406366F1) : Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${h['time']}', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 6),
                      Text('${h['icon']}', style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 6),
                      Text('${h['temp']}°', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyCard() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '7-DAY FORECAST',
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.2),
          ),
          const SizedBox(height: 12),
          ..._weekly.map((d) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                SizedBox(width: 40, child: Text('${d['day']}', style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 12, fontWeight: FontWeight.w500))),
                SizedBox(width: 28, child: Text('${d['icon']}', style: const TextStyle(fontSize: 16))),
                Expanded(child: Text('${d['cond']}', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12))),
                Text('${d['high']}°', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                const Text(' / ', style: TextStyle(color: Color(0xFF475569), fontSize: 12)),
                Text('${d['low']}°', style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.psychology_outlined, color: Color(0xFF818CF8), size: 14),
            SizedBox(width: 8),
            Text('AI Weather Insights', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 12),
        ..._suggestions.map((s) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: s.bg,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              border: Border.all(color: s.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(s.icon, color: s.iconColor, size: 14),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(s.text, style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 12, height: 1.6)),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}

class _Suggestion {
  const _Suggestion({
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.bg,
    required this.border,
  });
  final IconData icon;
  final Color iconColor;
  final String text;
  final Color bg;
  final Color border;
}