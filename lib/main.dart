import 'package:flutter/material.dart';

void main() {
  runApp(const AIGamingCopilotApp());
}

class AIGamingCopilotApp extends StatelessWidget {
  const AIGamingCopilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Gaming Co-Pilot',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
      ),
      home: const CopilotHomeScreen(),
    );
  }
}

class CopilotHomeScreen extends StatefulWidget {
  const CopilotHomeScreen({super.key});

  @override
  State<CopilotHomeScreen> createState() => _CopilotHomeScreenState();
}

class _CopilotHomeScreenState extends State<CopilotHomeScreen> {
  final TextEditingController _promptController = TextEditingController();
  String _selectedGame = "Free Fire (Offline Simulation)";
  String _activeDirective = "Auto-Combat, Damage Focus & Smart Cover";
  bool _isEngineRunning = false;

  final List<String> _availableGames = [
    "Free Fire (Offline Simulation)",
    "Offline Tactical Shooter",
    "Action Battle Arena",
  ];

  void _showGameSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Target Game / App",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              ..._availableGames.map((game) => ListTile(
                    leading: const Icon(Icons.sports_esports, color: Colors.redAccent),
                    title: Text(game, style: const TextStyle(color: Colors.white)),
                    onTap: () {
                      setState(() => _selectedGame = game);
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        );
      },
    );
  }

  void _toggleEngine() {
    setState(() {
      _isEngineRunning = !_isEngineRunning;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _isEngineRunning ? Colors.redAccent : Colors.grey,
        content: Text(
          _isEngineRunning
              ? "AI Autopilot Engine ACTIVE (Red Dot Overlay Ready)"
              : "AI Autopilot Engine STOPPED",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.memory, color: Colors.redAccent),
            SizedBox(width: 8),
            Text("AI Pro-Gamer Co-Pilot", style: TextStyle(fontSize: 18)),
          ],
        ),
        actions: [
          if (_isEngineRunning)
            Container(
              margin: const EdgeInsets.only(right: 16),
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isEngineRunning ? Colors.redAccent : Colors.white12,
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      child: Icon(Icons.gamepad, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedGame,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Directive: $_activeDirective",
                            style: const TextStyle(fontSize: 12, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isEngineRunning ? Colors.grey : Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _toggleEngine,
                    icon: Icon(_isEngineRunning ? Icons.stop : Icons.play_arrow, color: Colors.white),
                    label: Text(
                      _isEngineRunning ? "STOP AI ENGINE" : "START 100% AUTOPILOT",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "30 Tactical Rules Loaded • 120 FPS Vision Ready\nSet your one-time directive below and tap START.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: const Color(0xFF1E1E1E),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.redAccent, size: 30),
                  onPressed: _showGameSelector,
                ),
                Expanded(
                  child: TextField(
                    controller: _promptController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Enter gameplay command...",
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: () {
                    if (_promptController.text.trim().isNotEmpty) {
                      setState(() {
                        _activeDirective = _promptController.text.trim();
                        _promptController.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
