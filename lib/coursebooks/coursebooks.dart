import 'package:flutter/material.dart';
import 'package:untitled/coursebooks/coursebooks.dart';
import 'package:untitled/Homepage/Homepage.dart';
import 'package:untitled/ai/ai.dart';
import 'package:untitled/homeactivities/homeactivities.dart';
import 'package:untitled/timetable/timetable.dart';
import 'package:untitled/notepad/notepad.dart';
import 'package:untitled/complaint/complaint.dart';
import 'package:untitled/pastpapers/pastpapers.dart';
import 'package:untitled/announce/announce.dart';
import 'package:untitled/courseguide/courseguide.dart';
import 'package:untitled/dictionary/dictionary.dart';


class CourseBooksPage extends StatefulWidget {
  @override
  _CourseBooksPageState createState() => _CourseBooksPageState();
}

class _CourseBooksPageState extends State<CourseBooksPage> {
  final Map<String, List<String>> _subjects = {
    "1st Semester": [
      "Applied Physics",
      "Programming Fundamentals",
      "Information Technology",
      "Ideology of Pakistan",
      "Functional English"
    ],
    "2nd Semester": [
      "Object-Oriented Programming",
      "Digital Logic Design",
      "Database Systems",
      "Expository Writing",
      "Discrete Structures"
    ],
    "3rd Semester": [
      "Data Structures and Algorithms",
      "Probability and Statistics",
      "Mobile Computing",
      "Information Security",
      "Calculus and Analytical Geometry"
    ],
  };

  String? _selectedSemester;
  String? _selectedSubject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF036AA4),
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 8),
            const Text(
              'AirAcademia',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return _buildNavigationDrawer(context);
              },
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'asset/logo2.jpg',
              height: 40,
              width: 40,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: const Text(
                  'Air University, Islamabad',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF036AA4),
                  ),
                ),
              ),
              Center(
                child: const Text(
                  'Course Books',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF036AA4),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Dropdown for semesters
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  width: 345,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(75),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedSemester,
                    hint: const Text(
                      "Select the semester",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                    icon: const Icon(
                        Icons.arrow_drop_down, color: Colors.black),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Times New Roman',
                    ),
                    underline: Container(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSemester = newValue;
                        _selectedSubject = null;
                      });
                    },
                    items: _subjects.keys.map<DropdownMenuItem<String>>((
                        String semester) {
                      return DropdownMenuItem<String>(
                        value: semester,
                        child: Text(semester),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Dropdown for subjects
              if (_selectedSemester != null)
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    width: 450,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(75),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedSubject,
                      hint: const Text(
                        "Select the subject",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                      icon: const Icon(
                          Icons.arrow_drop_down, color: Colors.black),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Times New Roman',
                      ),
                      underline: Container(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSubject = newValue;
                        });
                      },
                      items: _subjects[_selectedSemester]!
                          .map<DropdownMenuItem<String>>((String subject) {
                        return DropdownMenuItem<String>(
                          value: subject,
                          child: Text(subject),
                        );
                      }).toList(),
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              // Display center logo if no selection is made
              if (_selectedSemester == null && _selectedSubject == null)
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'asset/logo1.jpg', // Replace with your logo asset path
                      fit: BoxFit.contain,
                      width: 400, // Increased size for better visibility
                      height: 400,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationDrawer(BuildContext context) {
    return Container(
      color: Color(0xFF036AA4),
      child: ListView(
        children: [
          _buildNavItem(context, "Home", Icons.home, HomePage()),
          _buildNavItem(context, "Timetable", Icons.schedule, TimetableApp()),
          _buildNavItem(context, "Course Guide", Icons.book, CourseGuidePage()),
          _buildNavItem(
              context, "Course Books", Icons.menu_book, CourseBooksPage()),
          _buildNavItem(
              context, "Home Activities", Icons.home, HomeActivitiesPage()),
          _buildNavItem(context, "Past Papers", Icons.quiz, PastPapersPage()),
          _buildNavItem(context, "Notepad", Icons.note, NotepadPage1()),
          _buildNavItem(context, "AI", Icons.smart_toy, AiChatboxPage()),
          _buildNavItem(
              context, "Complaints", Icons.report_problem, ComplaintsScreen()),
          _buildNavItem(context, "Announcements", Icons.announcement,
              AnnouncementsPage()),

          ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text("Logout", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ThirdScreen()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, IconData icon,
      Widget targetPage) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => targetPage));
      },
    );
  }
}