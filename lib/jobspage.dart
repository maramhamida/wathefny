/*import 'package:flutter/material.dart';

class JobsPage extends StatefulWidget {
  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  String selectedFilter = "all";

  // قائمة الوظائف
  List<Map<String, String>> jobs = [
    {"title": "UI/UX Designer", "company": "Airbnb", "category": "design"},
    {"title": "Writer Specialist", "company": "Upwork", "category": "writer"},
    {"title": "Marketing Advisor", "company": "Meta", "category": "marketing"},
    {"title": "Data Engineer", "company": "LinkedIn", "category": "engineer"},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredJobs = selectedFilter == "all"
        ? jobs
        : jobs.where((job) => job["category"] == selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Hi Adam"),
        backgroundColor: Color(0xFF6B8755),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------ الفلاتر ---------------------
          Container(
            padding: EdgeInsets.all(12),
            child: Wrap(
              spacing: 10,
              children: [
                buildFilterButton("All Job", "all"),
                buildFilterButton("designe", "design"),
                buildFilterButton("writer", "writer"),
                buildFilterButton("Marketing", "marketing"),
                buildFilterButton("Engineer", "engineer"),
              ],
            ),
          ),

          // ------------------ قائمة الوظائف ---------------------
          Expanded(
            child: ListView.builder(
              itemCount: filteredJobs.length,
              itemBuilder: (context, index) {
                final job = filteredJobs[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JobDetailsPage(job: job),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job["title"]!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          job["company"]!,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // زر الفلتر
  Widget buildFilterButton(String label, String value) {
    bool isActive = selectedFilter == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF6B8755) : Colors.white,
          border: Border.all(color: Color(0xFF6B8755)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.white : Color(0xFF6B8755),
          ),
        ),
      ),
    );
  }
}

// ------------------ صفحة التفاصيل -----------------------
class JobDetailsPage extends StatelessWidget {
  final Map<String, String> job;

  JobDetailsPage({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job["title"]!),
        backgroundColor: Color(0xFF6B8755),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job["title"]!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              job["company"]!,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 30),
            Text(
              "Job Details will appear here...",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}*/
