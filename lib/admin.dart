import 'package:flutter/material.dart';

void main() => runApp(const PotholeAdminApp());

class PotholeAdminApp extends StatelessWidget {
  const PotholeAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          NavigationRail(
            extended: true,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('Overview'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.map),
                label: Text('Pothole Map'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.report_problem),
                label: Text('Reports'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
            selectedIndex: 0,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pothole Detection Summary",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // Stats Grid
                  const Row(
                    children: [
                      StatCard(
                        title: "Total Detected",
                        value: "1,240",
                        color: Colors.blue,
                      ),
                      StatCard(
                        title: "High Severity",
                        value: "84",
                        color: Colors.red,
                      ),
                      StatCard(
                        title: "Repaired",
                        value: "912",
                        color: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Recent Reports",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Table
                  Expanded(
                    child: Card(
                      child: ListView.separated(
                        itemCount: 10,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) => ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Icon(Icons.warning, color: Colors.white),
                          ),
                          title: Text(
                            "Pothole detected at Location ID: #00${index + 120}",
                          ),
                          subtitle: const Text(
                            "Detected via Mobile App • 2 hours ago",
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {},
                            child: const Text("View Details"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title, value;
  final Color color;
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
