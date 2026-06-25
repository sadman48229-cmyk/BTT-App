import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';

class GlossaryPage extends StatefulWidget {
  const GlossaryPage({super.key});

  @override
  State<GlossaryPage> createState() => _GlossaryPageState();
}

class _GlossaryPageState extends State<GlossaryPage> {
  final TextEditingController _search = TextEditingController();
  String _query = '';

  final List<_GlossaryItem> _terms = const [
    _GlossaryItem('BAC', 'Blood Alcohol Content', 'The amount of alcohol in your blood, measured as a percentage. Legal limit in Singapore is 80mg/100ml (0.08%).'),
    _GlossaryItem('BUS LANE', 'Dedicated Bus Lane', 'A lane reserved for buses during specified hours. Usually marked with yellow lines and "BUS LANE" text on the road.'),
    _GlossaryItem('CEPAS', 'Contactless e-Purse Application Scheme', 'Singapore\'s cashless payment system used in ERP gantries and carparks.'),
    _GlossaryItem('ERP', 'Electronic Road Pricing', 'Singapore\'s electronic toll system that charges drivers for using certain roads during peak hours.'),
    _GlossaryItem('Expressway', 'Major Highway', 'A major road for fast, long-distance travel with limited access (no traffic lights). Examples: PIE, AYE, CTE.'),
    _GlossaryItem('Give Way', 'Yield', 'You must slow down or stop to allow traffic on the main road to pass before you proceed.'),
    _GlossaryItem('Hard Shoulder', 'Emergency Lane', 'The paved strip at the side of an expressway, reserved for breakdowns and emergencies only.'),
    _GlossaryItem('IU', 'In-Vehicle Unit', 'The device installed in your car that deducts ERP charges automatically as you pass through gantries.'),
    _GlossaryItem('Junction', 'Intersection', 'A place where two or more roads meet or cross each other.'),
    _GlossaryItem('Kerb', 'Curb', 'The raised edge of a pavement/sidewalk. Parking rules often reference distance from the kerb.'),
    _GlossaryItem('Lane Discipline', 'Keeping to Your Lane', 'The practice of staying in your lane and not weaving unnecessarily between lanes.'),
    _GlossaryItem('LTA', 'Land Transport Authority', 'Singapore\'s government agency responsible for planning, operating, and maintaining Singapore\'s land transport infrastructure.'),
    _GlossaryItem('Mandatory Sign', 'Compulsory Sign', 'A road sign (usually circular with red border) that MUST be obeyed. Example: No Entry, Speed Limit.'),
    _GlossaryItem('MCE', 'Marina Coastal Expressway', 'Singapore\'s underground expressway connecting the city centre to other major expressways.'),
    _GlossaryItem('No-Entry Zone', 'Prohibited Entry Area', 'A road or area where vehicles are not permitted to enter, indicated by a circular red sign with white horizontal bar.'),
    _GlossaryItem('Overtaking', 'Passing Another Vehicle', 'Driving past a slower vehicle ahead of you, usually from the right side in Singapore.'),
    _GlossaryItem('PIE', 'Pan Island Expressway', 'Singapore\'s longest expressway, running across the island from west to east.'),
    _GlossaryItem('Right of Way', 'Priority to Proceed', 'The legal right to proceed first in a traffic situation. The vehicle with right of way goes first.'),
    _GlossaryItem('Road Marking', 'Painted Road Sign', 'Lines, words, or symbols painted on the road surface to guide and direct traffic.'),
    _GlossaryItem('Shoulder Lane', 'Emergency Stopping Lane', 'The outer lane on an expressway, used only when directed or for emergencies.'),
    _GlossaryItem('Speed Camera', 'Traffic Enforcement Camera', 'An automatic camera that captures images of vehicles exceeding the speed limit.'),
    _GlossaryItem('Stop Line', 'Halt Line', 'A white line across the road at a junction where you must stop before proceeding.'),
    _GlossaryItem('Traffic Warden', 'Traffic Enforcement Officer', 'A person authorized to direct traffic and issue summonses for traffic violations.'),
    _GlossaryItem('Turning Pocket', 'Dedicated Turn Lane', 'A special lane that allows vehicles to wait to turn without blocking through traffic.'),
    _GlossaryItem('Warning Sign', 'Hazard Sign', 'A triangular sign with a red border that warns of potential dangers ahead. Slows drivers down.'),
    _GlossaryItem('Zebra Crossing', 'Pedestrian Crossing', 'A black and white striped crossing where pedestrians have right of way over vehicles.'),
  ];

  List<_GlossaryItem> get _filtered => _query.isEmpty
      ? _terms
      : _terms.where((t) =>
          t.term.toLowerCase().contains(_query.toLowerCase()) ||
          t.shortDesc.toLowerCase().contains(_query.toLowerCase())).toList();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final grouped = <String, List<_GlossaryItem>>{};
    for (final item in _filtered) {
      final key = item.term[0].toUpperCase();
      grouped.putIfAbsent(key, () => []).add(item);
    }
    final sortedKeys = grouped.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Glossary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              controller: _search,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search terms...',
                prefixIcon: const Icon(Icons.search_rounded, size: 20),
                suffixIcon: _query.isNotEmpty
                    ? GestureDetector(
                        onTap: () { _search.clear(); setState(() => _query = ''); },
                        child: const Icon(Icons.close_rounded, size: 18))
                    : null,
              ),
            ).animate().fadeIn(duration: 400.ms),
          ),

          // List
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🔍', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text('No terms matching "$_query"',
                            style: TextStyle(fontSize: 16, color: AppColors.darkTextSecondary)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: sortedKeys.fold<int>(0, (sum, k) => sum + 1 + grouped[k]!.length),
                    itemBuilder: (context, flatIndex) {
                      int current = 0;
                      for (final key in sortedKeys) {
                        if (flatIndex == current) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 6),
                            child: Text(key,
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primary)),
                          );
                        }
                        current++;
                        final items = grouped[key]!;
                        for (final item in items) {
                          if (flatIndex == current) return _TermCard(item: item, isDark: isDark);
                          current++;
                        }
                      }
                      return const SizedBox.shrink();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _GlossaryItem {
  final String term;
  final String shortDesc;
  final String fullDesc;
  const _GlossaryItem(this.term, this.shortDesc, this.fullDesc);
}

class _TermCard extends StatefulWidget {
  final _GlossaryItem item;
  final bool isDark;
  const _TermCard({required this.item, required this.isDark});

  @override
  State<_TermCard> createState() => _TermCardState();
}

class _TermCardState extends State<_TermCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _expanded ? AppColors.primary.withOpacity(0.4) : (widget.isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: _expanded ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.item.term,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800,
                              color: _expanded ? AppColors.primary : (widget.isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary))),
                      const SizedBox(height: 2),
                      Text(widget.item.shortDesc,
                          style: TextStyle(fontSize: 12, color: widget.isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
                    ],
                  ),
                ),
                Icon(_expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    color: widget.isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
              ],
            ),
            if (_expanded) ...[
              const SizedBox(height: 10),
              Divider(color: widget.isDark ? AppColors.darkBorder : AppColors.lightBorder, height: 1),
              const SizedBox(height: 10),
              Text(widget.item.fullDesc,
                  style: TextStyle(fontSize: 13, height: 1.6,
                      color: widget.isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
            ],
          ],
        ),
      ),
    );
  }
}
