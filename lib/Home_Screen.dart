import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  HomeScreen({required this.userName});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = "all";
  int currentIndex = 0; // للتحكم في شريط التنقل السفلي
  bool showSearchPosts = false; // للتحكم بعرض البحث كقائمة بوستات

  // قائمة الوظائف
  List<Map<String, String>> jobs = [
    {
      "title": "UI/UX Designer",
      "company": "Airbnb",
      "deadline": "2025-12-31",
      "category": "design",
    },
    {
      "title": "Writer Specialist",
      "company": "Upwork",
      "deadline": "2025-12-20",
      "category": "writer",
    },
    {
      "title": "Marketing Advisor",
      "company": "Meta",
      "deadline": "2025-12-25",
      "category": "marketing",
    },
    {
      "title": "Data Engineer",
      "company": "LinkedIn",
      "deadline": "2025-12-28",
      "category": "engineer",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredJobs = selectedFilter == "all"
        ? jobs
        : jobs.where((job) => job["category"] == selectedFilter).toList();

    final screens = [
      showSearchPosts ? buildJobList(filteredJobs) : buildJobList(filteredJobs),
      Center(child: Text("Messages Page")),
      Center(child: Text("Notifications Page")),
      Center(child: Text("Profile Page")),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6B8755),
        title: Text("Hi ${widget.userName}"),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Color(0xFF6B8755),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            // زر البحث
            setState(() {
              showSearchPosts = !showSearchPosts;
              currentIndex = 0; // يرجع لصفحة الوظائف مع البحث
            });
          } else {
            setState(() {
              currentIndex = index;
              showSearchPosts = false; // اخفاء البحث إذا انتقل لصفحة ثانية
            });
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget buildJobList(List<Map<String, String>> jobsList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          child: Wrap(
            spacing: 10,
            children: [
              buildFilterButton("All Job", "all"),
              buildFilterButton("Design", "design"),
              buildFilterButton("Writer", "writer"),
              buildFilterButton("Marketing", "marketing"),
              buildFilterButton("Engineer", "engineer"),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: jobsList.length,
            itemBuilder: (context, index) {
              final job = jobsList[index];
              return buildJobCard(job);
            },
          ),
        ),
      ],
    );
  }

  Widget buildFilterButton(String label, String value) {
    bool isActive = selectedFilter == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = value;
        });
      },
      child: Container(
        width: 115,
        height: 37.5,
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF4CA6A8) : Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.5), width: 1),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(4, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.white : Colors.black.withOpacity(0.8),
          ),
        ),
      ),
    );
  }

  Widget buildJobCard(Map<String, String> job) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.5), width: 1),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(4, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          // صورة افتراضية للشركة
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job["title"]!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  job["company"]!,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4CA6A8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => JobDetailsPage(job: job)),
              );
            },
            child: Text("Apply Now"),
          ),
        ],
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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              job["company"]!,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 10),
            Text(
              'Deadline: ${job["deadline"]!}',
              style: TextStyle(fontSize: 16, color: Colors.red),
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
}
