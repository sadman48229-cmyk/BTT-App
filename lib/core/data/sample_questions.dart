import '../../shared/models/question_model.dart';

class SampleQuestions {
  static List<QuestionModel> get all => _questions;

  static List<QuestionModel> get({
    String? chapterId,
    String? difficulty,
    int count = 10,
  }) {
    var filtered = _questions;

    if (chapterId != null) {
      filtered = filtered.where((q) => q.chapterId == chapterId).toList();
    }

    if (difficulty != null) {
      final d = Difficulty.values.firstWhere(
        (e) => e.name == difficulty,
        orElse: () => Difficulty.medium,
      );
      filtered = filtered.where((q) => q.difficulty == d).toList();
    }

    filtered.shuffle();
    return filtered.take(count.clamp(0, filtered.length)).toList();
  }

  static final List<QuestionModel> _questions = [
    // Road Signs
    QuestionModel(
      id: 'q001',
      question: 'A circular red sign with a white horizontal bar means:',
      options: [
        'Speed limit applies',
        'Entry is prohibited for all vehicles',
        'Parking is not allowed',
        'Road is closed for repairs',
      ],
      correctOptionIndex: 1,
      explanation: 'A circular red sign with a white horizontal bar is the "No Entry" sign. It means no vehicles may enter from that direction. This is one of the most important prohibition signs.',
      wrongExplanations: [
        'Speed limits are shown in circular signs with the number inside.',
        'No parking signs are circular with a red cross or a "P" crossed out.',
        'Road closure signs have different shapes and are usually advisory.',
      ],
      difficulty: Difficulty.easy,
      chapterId: 'road_signs',
      chapterName: 'Road Signs',
      tags: ['prohibition', 'entry', 'mandatory'],
      estimatedTimeSeconds: 45,
      createdAt: DateTime(2024, 1, 1),
    ),
    QuestionModel(
      id: 'q002',
      question: 'What does a triangular sign with a red border indicate?',
      options: [
        'A mandatory instruction that must be followed',
        'A warning of a hazard or potential danger ahead',
        'Information about directions or facilities',
        'Speed limits on the road',
      ],
      correctOptionIndex: 1,
      explanation: 'Triangular signs with red borders are WARNING signs. They alert drivers to potential hazards or dangers ahead, such as sharp bends, junctions, or road works. Always slow down and be alert when you see these.',
      wrongExplanations: [
        'Mandatory signs are circular (round) with red borders.',
        'Information signs are rectangular and usually blue or green.',
        'Speed limit signs are circular with red borders and numbers inside.',
      ],
      difficulty: Difficulty.easy,
      chapterId: 'road_signs',
      chapterName: 'Road Signs',
      tags: ['warning', 'shapes', 'basic'],
      estimatedTimeSeconds: 45,
      createdAt: DateTime(2024, 1, 1),
    ),
    QuestionModel(
      id: 'q003',
      question: 'What does a "Give Way" sign look like in Singapore?',
      options: [
        'A red octagon with "STOP" written on it',
        'An inverted triangle (pointing down) with a red border',
        'A yellow diamond shape',
        'A blue circle with an arrow',
      ],
      correctOptionIndex: 1,
      explanation: 'The "Give Way" sign in Singapore is an inverted triangle (pointing downward) with a red border and white interior. When you see this sign, you must slow down and give way to traffic on the major road.',
      wrongExplanations: [
        'A red octagon is the "STOP" sign — you must stop completely.',
        'Yellow diamonds are used in some countries but not in Singapore.',
        'Blue circles are used for mandatory signs like one-way traffic.',
      ],
      difficulty: Difficulty.easy,
      chapterId: 'road_signs',
      chapterName: 'Road Signs',
      tags: ['give way', 'priority', 'intersection'],
      estimatedTimeSeconds: 45,
      createdAt: DateTime(2024, 1, 1),
    ),

    // Road Markings
    QuestionModel(
      id: 'q004',
      question: 'A continuous white line in the center of a two-way road means:',
      options: [
        'You may overtake if the road is clear',
        'You must not cross or straddle the line',
        'The road is one-way only',
        'A bus lane begins here',
      ],
      correctOptionIndex: 1,
      explanation: 'A continuous (unbroken) white center line must never be crossed or straddled. It separates opposing traffic and crossing it is dangerous and illegal. Only broken white lines may be crossed when safe.',
      wrongExplanations: [
        'You may only overtake when there is a broken (dashed) white center line.',
        'One-way roads do not have center lines separating opposing traffic.',
        'Bus lanes are marked with "BUS LANE" text and yellow lines.',
      ],
      difficulty: Difficulty.medium,
      chapterId: 'road_markings',
      chapterName: 'Road Markings',
      tags: ['center line', 'overtaking', 'prohibition'],
      estimatedTimeSeconds: 60,
      createdAt: DateTime(2024, 1, 1),
    ),
    QuestionModel(
      id: 'q005',
      question: 'Double yellow lines at the side of the road indicate:',
      options: [
        'You may park here for up to 30 minutes',
        'No parking or waiting at any time',
        'Loading and unloading only',
        'Parking allowed on weekends only',
      ],
      correctOptionIndex: 1,
      explanation: 'Double yellow lines (two parallel yellow lines) at the side of the road mean NO PARKING OR WAITING at any time — not even briefly. This is stricter than a single yellow line, which may allow brief stops.',
      wrongExplanations: [
        'No time limit is allowed on double yellow lines.',
        'Loading zones are usually marked with specific signs and white lines.',
        'Weekend exceptions do not apply to double yellow lines.',
      ],
      difficulty: Difficulty.medium,
      chapterId: 'road_markings',
      chapterName: 'Road Markings',
      tags: ['yellow lines', 'parking', 'prohibition'],
      estimatedTimeSeconds: 60,
      createdAt: DateTime(2024, 1, 1),
    ),

    // Traffic Rules
    QuestionModel(
      id: 'q006',
      question: 'When approaching a pedestrian crossing with people waiting, you should:',
      options: [
        'Sound your horn to warn pedestrians',
        'Speed up to pass before pedestrians step out',
        'Slow down and be prepared to stop to give way to pedestrians',
        'Flash your headlights and continue',
      ],
      correctOptionIndex: 2,
      explanation: 'When you see pedestrians at or approaching a crossing, you MUST slow down and be prepared to stop. Pedestrians have right of way at marked crossings. Failing to give way is a serious traffic offense in Singapore.',
      wrongExplanations: [
        'Sounding the horn is aggressive and does not give you right of way.',
        'Speeding up is extremely dangerous and illegal.',
        'Flashing lights is also inappropriate — you must slow down and give way.',
      ],
      difficulty: Difficulty.easy,
      chapterId: 'traffic_rules',
      chapterName: 'Traffic Rules',
      tags: ['pedestrian', 'crossing', 'right of way'],
      estimatedTimeSeconds: 45,
      createdAt: DateTime(2024, 1, 1),
    ),
    QuestionModel(
      id: 'q007',
      question: 'What is the minimum following distance you should maintain on a normal road in dry conditions?',
      options: [
        '1 car length',
        '2 car lengths',
        'At least 2 seconds (the two-second rule)',
        '5 meters',
      ],
      correctOptionIndex: 2,
      explanation: 'The two-second rule is the standard minimum safe following distance in dry conditions. Pick a stationary object — when the car ahead passes it, you should take at least 2 seconds to reach the same point. In wet conditions, double this to 4 seconds.',
      wrongExplanations: [
        '1 car length is far too close, especially at higher speeds.',
        'A fixed number of car lengths depends on speed — the time rule is safer.',
        'A fixed distance of 5 meters is not enough at highway speeds.',
      ],
      difficulty: Difficulty.medium,
      chapterId: 'traffic_rules',
      chapterName: 'Traffic Rules',
      tags: ['following distance', 'safety', 'two-second rule'],
      estimatedTimeSeconds: 60,
      createdAt: DateTime(2024, 1, 1),
    ),
    QuestionModel(
      id: 'q008',
      question: 'You are at a traffic light and the amber light appears. You should:',
      options: [
        'Speed up to pass through before red',
        'Stop safely if you can do so without harsh braking',
        'Sound your horn to warn following traffic',
        'Flash your hazard lights and proceed',
      ],
      correctOptionIndex: 1,
      explanation: 'Amber means CAUTION — stop if you can do so safely. The amber light warns you that red is coming. If you are too close to the stop line and stopping would be unsafe, you may proceed carefully. Speeding up through amber is dangerous and illegal.',
      wrongExplanations: [
        'Speeding up through amber is a traffic violation and dangerous.',
        'Sounding the horn has no legal purpose here.',
        'Hazard lights should only be used when stationary in an emergency.',
      ],
      difficulty: Difficulty.easy,
      chapterId: 'traffic_rules',
      chapterName: 'Traffic Rules',
      tags: ['traffic light', 'amber', 'stopping'],
      estimatedTimeSeconds: 45,
      createdAt: DateTime(2024, 1, 1),
    ),

    // Parking
    QuestionModel(
      id: 'q009',
      question: 'You want to park your car at night. Your vehicle must have:',
      options: [
        'Headlights turned on',
        'Hazard lights flashing',
        'Parking lights (if on a road with no street lighting) or no lights if parked off-road',
        'Full interior lighting on',
      ],
      correctOptionIndex: 2,
      explanation: 'When parking on a road at night where there is no street lighting, you must leave your parking lights on so other road users can see your vehicle. On well-lit roads or in designated parking areas, lights may not be required.',
      wrongExplanations: [
        'Full headlights are not necessary when parked — they would dazzle other drivers.',
        'Hazard lights should not be used for long-term parking.',
        'Interior lighting does not make your vehicle visible to other road users.',
      ],
      difficulty: Difficulty.medium,
      chapterId: 'parking',
      chapterName: 'Parking Rules',
      tags: ['night parking', 'lights', 'safety'],
      estimatedTimeSeconds: 60,
      createdAt: DateTime(2024, 1, 1),
    ),
    QuestionModel(
      id: 'q010',
      question: 'Which of the following is NOT an illegal parking location in Singapore?',
      options: [
        'Within 6 meters of a junction',
        'On a zebra crossing or its approaches',
        'In a designated HDB carpark with a valid coupon',
        'In front of a fire hydrant',
      ],
      correctOptionIndex: 2,
      explanation: 'Parking in a designated carpark with proper authorization (valid coupon, season parking, or electronic system) is legal. The other options are all illegal parking locations that obstruct traffic or emergency services.',
      wrongExplanations: [
        'Parking within 6 meters of a junction is illegal as it blocks visibility.',
        'Parking on or near a zebra crossing is illegal and endangers pedestrians.',
        'Parking in front of a fire hydrant is illegal and obstructs emergency access.',
      ],
      difficulty: Difficulty.medium,
      chapterId: 'parking',
      chapterName: 'Parking Rules',
      tags: ['illegal parking', 'carpark', 'Singapore'],
      estimatedTimeSeconds: 60,
      createdAt: DateTime(2024, 1, 1),
    ),

    // Speed Limits
    QuestionModel(
      id: 'q011',
      question: 'What is the general speed limit in Singapore for cars on expressways?',
      options: ['80 km/h', '90 km/h', '100 km/h', '110 km/h'],
      correctOptionIndex: 2,
      explanation: 'The general speed limit on Singapore expressways (like PIE, AYE, CTE, etc.) is 90 km/h. Some sections may have lower limits posted. Always follow the posted speed signs as they override the general limit.',
      wrongExplanations: [
        '80 km/h is the general limit for most major non-expressway roads.',
        '90 km/h is for some specific expressway sections.',
        '110 km/h exceeds Singapore\'s maximum speed limit.',
      ],
      difficulty: Difficulty.easy,
      chapterId: 'speed_limits',
      chapterName: 'Speed Limits',
      tags: ['expressway', 'speed limit', 'PIE', 'AYE'],
      estimatedTimeSeconds: 45,
      createdAt: DateTime(2024, 1, 1),
    ),
    QuestionModel(
      id: 'q012',
      question: 'In a school zone during school hours, what is the speed limit?',
      options: ['30 km/h', '40 km/h', '50 km/h', '60 km/h'],
      correctOptionIndex: 0,
      explanation: 'In school zones with flashing amber lights (indicating school hours), the speed limit is 40 km/h. Outside school hours when lights are not flashing, the normal road speed limit applies. Always watch for children near schools.',
      wrongExplanations: [
        '40 km/h applies to school zones only when amber warning lights are flashing.',
        '50 km/h is the general speed limit for many roads without special restrictions.',
        '60 km/h is too fast for areas with children.',
      ],
      difficulty: Difficulty.hard,
      chapterId: 'speed_limits',
      chapterName: 'Speed Limits',
      tags: ['school zone', 'speed limit', 'children'],
      estimatedTimeSeconds: 75,
      createdAt: DateTime(2024, 1, 1),
    ),

    // Right of Way
    QuestionModel(
      id: 'q013',
      question: 'At a cross junction with no traffic lights or signs, who has right of way?',
      options: [
        'The driver who arrives first',
        'The driver on the right',
        'The driver going straight (not turning)',
        'The driver on the larger/wider road',
      ],
      correctOptionIndex: 0,
      explanation: 'At an unmarked junction, the vehicle that arrives first has right of way. If vehicles arrive simultaneously, give way to the vehicle on your right. Always proceed cautiously at uncontrolled junctions.',
      wrongExplanations: [
        'The vehicle on the right only has priority when vehicles arrive simultaneously.',
        'Going straight does not automatically give you priority at uncontrolled junctions.',
        'Road width is not the determining factor at uncontrolled junctions.',
      ],
      difficulty: Difficulty.hard,
      chapterId: 'right_of_way',
      chapterName: 'Right of Way',
      tags: ['junction', 'right of way', 'priority'],
      estimatedTimeSeconds: 75,
      createdAt: DateTime(2024, 1, 1),
    ),
    QuestionModel(
      id: 'q014',
      question: 'When merging onto an expressway, who has the right of way?',
      options: [
        'The vehicle merging from the entry ramp',
        'The vehicle already on the expressway',
        'The faster vehicle',
        'The larger vehicle',
      ],
      correctOptionIndex: 1,
      explanation: 'Vehicles already on the expressway have right of way. When merging from an entry ramp, you must give way to traffic already on the expressway. Accelerate to match expressway speed and merge smoothly into a safe gap.',
      wrongExplanations: [
        'Merging vehicles must give way — they do not have right of way.',
        'Speed does not determine right of way.',
        'Vehicle size does not determine right of way.',
      ],
      difficulty: Difficulty.medium,
      chapterId: 'right_of_way',
      chapterName: 'Right of Way',
      tags: ['expressway', 'merging', 'right of way'],
      estimatedTimeSeconds: 60,
      createdAt: DateTime(2024, 1, 1),
    ),

    // Expressway Rules
    QuestionModel(
      id: 'q015',
      question: 'On a Singapore expressway, which lane should you normally drive in?',
      options: [
        'The rightmost lane for fastest travel',
        'Any lane you prefer',
        'The left lane unless overtaking',
        'The middle lane for safety',
      ],
      correctOptionIndex: 2,
      explanation: 'On Singapore expressways, you should drive in the left lane and only move to the right lane(s) to overtake. After overtaking, return to the left lane. Hogging the right lane unnecessarily is an offense.',
      wrongExplanations: [
        'The rightmost lane is for overtaking, not continuous driving.',
        'You cannot drive in any lane — keeping left is the rule.',
        'The middle lane is not the preferred lane — keep left.',
      ],
      difficulty: Difficulty.easy,
      chapterId: 'expressway',
      chapterName: 'Expressway Rules',
      tags: ['expressway', 'lane discipline', 'overtaking'],
      estimatedTimeSeconds: 45,
      createdAt: DateTime(2024, 1, 1),
    ),

    // Safety
    QuestionModel(
      id: 'q016',
      question: 'If your vehicle breaks down on an expressway, what should you do FIRST?',
      options: [
        'Call for help from the middle of the road',
        'Stay in your vehicle with seatbelt on',
        'Move your vehicle to the shoulder/hard shoulder, turn on hazard lights, and exit safely from the left side',
        'Walk to the nearest call box without moving the vehicle',
      ],
      correctOptionIndex: 2,
      explanation: 'If you break down on an expressway: (1) Move to the shoulder/emergency lane if possible, (2) Turn on hazard lights immediately, (3) Exit the vehicle from the left side away from traffic, (4) Move away from the vehicle and call for help. Never stand between your vehicle and oncoming traffic.',
      wrongExplanations: [
        'Standing on the expressway to call is extremely dangerous.',
        'Staying in the vehicle is dangerous if it\'s in a traffic lane.',
        'You should first move the vehicle off the road before seeking help.',
      ],
      difficulty: Difficulty.medium,
      chapterId: 'safety',
      chapterName: 'Road Safety',
      tags: ['breakdown', 'expressway', 'emergency', 'safety'],
      estimatedTimeSeconds: 75,
      createdAt: DateTime(2024, 1, 1),
    ),
    QuestionModel(
      id: 'q017',
      question: 'Using a mobile phone while driving (without hands-free) in Singapore can result in:',
      options: [
        'A verbal warning only for first offence',
        'A fine and/or imprisonment and demerit points',
        'Only demerit points with no fine',
        'Driving ban only for repeat offenders',
      ],
      correctOptionIndex: 1,
      explanation: 'In Singapore, using a handheld mobile phone while driving is a serious offense. Penalties include: fines up to S\$1,000 for first offense (higher for repeat), up to 6 months imprisonment, and 6 demerit points. Always use hands-free devices.',
      wrongExplanations: [
        'There is no verbal warning — it is an offense with real penalties.',
        'Both fine and demerit points apply — there\'s no fine-only option.',
        'Bans and imprisonment can apply even for first-time serious offenses.',
      ],
      difficulty: Difficulty.medium,
      chapterId: 'safety',
      chapterName: 'Road Safety',
      tags: ['mobile phone', 'distracted driving', 'penalties'],
      estimatedTimeSeconds: 60,
      createdAt: DateTime(2024, 1, 1),
    ),

    // Vehicle Controls
    QuestionModel(
      id: 'q018',
      question: 'When should you use your hazard warning lights?',
      options: [
        'When driving slowly in bad weather',
        'When double parking to run a quick errand',
        'When your vehicle has broken down or is an obstruction',
        'When making a right turn at a junction',
      ],
      correctOptionIndex: 2,
      explanation: 'Hazard warning lights (all four indicators flashing) should only be used when your vehicle has broken down, is temporarily stopped in an emergency, or is an obstruction to other traffic. Misusing them (e.g., while driving in rain) can confuse other drivers.',
      wrongExplanations: [
        'In bad weather, use dipped headlights — not hazard lights while moving.',
        'Hazard lights do not make illegal double parking acceptable.',
        'Turn signals (not hazard lights) are used when turning.',
      ],
      difficulty: Difficulty.medium,
      chapterId: 'vehicle_controls',
      chapterName: 'Vehicle Controls',
      tags: ['hazard lights', 'warning', 'breakdown'],
      estimatedTimeSeconds: 60,
      createdAt: DateTime(2024, 1, 1),
    ),
    QuestionModel(
      id: 'q019',
      question: 'At what distance should you turn on your headlights at night?',
      options: [
        'Only when you cannot see ahead',
        'Headlights must be on from 30 minutes after sunset to 30 minutes before sunrise',
        'Only on unlit roads',
        'Only when other drivers flash their lights at you',
      ],
      correctOptionIndex: 1,
      explanation: 'In Singapore, you must use headlights from 30 minutes after sunset to 30 minutes before sunrise — even if the road is well lit. Headlights help others see YOUR vehicle, not just help you see the road.',
      wrongExplanations: [
        'Waiting until you can\'t see is too late — you need lights from sunset.',
        'Headlights are required even on lit roads during night hours.',
        'Don\'t wait for others to flash — use headlights proactively.',
      ],
      difficulty: Difficulty.medium,
      chapterId: 'vehicle_controls',
      chapterName: 'Vehicle Controls',
      tags: ['headlights', 'night driving', 'visibility'],
      estimatedTimeSeconds: 60,
      createdAt: DateTime(2024, 1, 1),
    ),
    QuestionModel(
      id: 'q020',
      question: 'What is the legal BAC (Blood Alcohol Content) limit for drivers in Singapore?',
      options: [
        '0.08% (80mg per 100ml of blood)',
        '0.05% (50mg per 100ml of blood)',
        '0.10% (100mg per 100ml of blood)',
        '0.00% — zero tolerance',
      ],
      correctOptionIndex: 0,
      explanation: 'Singapore\'s legal BAC limit is 80mg of alcohol per 100ml of blood (0.08%). However, even below the legal limit, alcohol impairs driving. The safest approach is zero alcohol when driving. Penalties for drunk driving are severe, including imprisonment.',
      wrongExplanations: [
        '0.05% is the limit in some other countries, not Singapore.',
        '0.10% is higher than the Singapore legal limit.',
        'While zero is the safest, the legal limit is 80mg/100ml.',
      ],
      difficulty: Difficulty.hard,
      chapterId: 'safety',
      chapterName: 'Road Safety',
      tags: ['alcohol', 'drunk driving', 'BAC', 'legal limit'],
      estimatedTimeSeconds: 75,
      createdAt: DateTime(2024, 1, 1),
    ),
  ];
}
