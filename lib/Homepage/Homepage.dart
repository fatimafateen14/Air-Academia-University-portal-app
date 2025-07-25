import 'package:flutter/material.dart';
import 'dart:async';
import 'package:untitled/Homepage/Homepage.dart';
import 'package:untitled/ai/ai.dart';
import 'package:untitled/homeactivities/homeactivities.dart';
import 'package:untitled/timetable/timetable.dart';
import 'package:untitled/notepad/notepad.dart';
import 'package:untitled/complaint/complaint.dart';
import 'package:untitled/pastpapers/pastpapers.dart';
import 'package:untitled/announce/announce.dart';
import 'package:untitled/courseguide/courseguide.dart';
import 'package:untitled/coursebooks/coursebooks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:untitled/dictionary/dictionary.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

final String classroomUrl = 'https://classroom.google.com/';
Future<void> _navigateToClassroom() async {
  if (await canLaunch(classroomUrl)) {
    await launch(classroomUrl);
  } else {
    throw 'Could not launch $classroomUrl';
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();

    // Navigate to the second screen with a fade transition after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => SecondScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'asset/logo1.jpg', // Replace with your logo image path
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> with TickerProviderStateMixin {
  final String fullText = 'Welcome to AirAcademia';
  final String platformText = 'A Platform for Academic Excellence and Innovation.';
  final String subText = 'An initiative by Air University';
  bool showButton = false;
  late AnimationController _controller;
  late Animation<double> _logoScaleAnimation;
  bool textComplete = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();

    _showText();
  }

  void _showText() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      textComplete = true;
    });

    // Show the button after the text animation
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      showButton = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF036AA4),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo inside a larger circle with smooth animation
              AnimatedBuilder(
                animation: _logoScaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _logoScaleAnimation.value,
                    child: Container(
                      width: 180.0,  // Increased size of the circle
                      height: 180.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'asset/logo1.jpg', // Replace with your logo image path
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0),
              // Text animation with smoother transitions
              Column(
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 1000),
                    child: Text(
                      fullText,
                      key: ValueKey('line1'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,  // Larger font size for the first line
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  // Apply fade transition for subsequent lines
                  AnimatedOpacity(
                    opacity: textComplete ? 1.0 : 0.0,
                    duration: Duration(seconds: 1),
                    child: Column(
                      children: [
                        Text(
                          platformText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,  // Slightly smaller font size for the second line
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          subText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,  // Small font size for the third line
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Apply smooth button animation
              AnimatedOpacity(
                opacity: showButton ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Column(
                  children: [
                    SizedBox(height: 40.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ThirdScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF036AA4),
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text('Get Started with Us'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF036AA4), // Full background color
      body: Center(
        child: Container(
          width: 300.0,
          padding: EdgeInsets.all(20.0), // Padding inside the box
          decoration: BoxDecoration(
            color: Colors.white, // Box background color
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black26, // Shadow color
                blurRadius: 10.0, // Shadow blur
                offset: Offset(0, 5), // Shadow position
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjust size to content
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top text
              Text(
                'AirAcademia Login',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF036AA4), // Matching theme color
                ),
              ),
              SizedBox(height: 10.0),
              // Logo
              Image.asset(
                'asset/logo1.jpg', // Path to your logo
                width: 100.0,
                height: 100.0,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10.0),
              // Email TextField
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Color(0xFF036AA4), // Same color as login button
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white), // Text color
              ),
              SizedBox(height: 10.0),
              // Password TextField
              TextField(
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Color(0xFF036AA4), // Same color as login button
                  hintStyle: TextStyle(color: Colors.white70),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                style: TextStyle(color: Colors.white), // Text color
              ),
              SizedBox(height: 20.0),
              // Login button
              ElevatedButton(
                onPressed: () {
                  // Navigate to HomePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF036AA4), // Button color
                  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class HomePage extends StatelessWidget {
  final String classroomUrl = 'https://classroom.google.com/';

  // Method to navigate to Google Classroom
  Future<void> _navigateToClassroom() async {
    if (await canLaunch(classroomUrl)) {
      await launch(classroomUrl);
    } else {
      throw 'Could not launch $classroomUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF036AA4),
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "AirAcademia",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Times New Roman',
              ),
            ),
            Image.asset(
              'asset/logo2.jpg',
              height: 40,
              width: 40,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // First Row: 3 Boxes
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGridItem(context, "Notepad", "asset/notepad.jpg", NotepadPage1()),
                  SizedBox(width: 15),
                  _buildGridItem(context, "Course Guide", "asset/course.jpg", CourseGuidePage()),
                  SizedBox(width: 15),
                  _buildGridItem(context, "Complaint", "asset/complaint.jpg", ComplaintsApp()),
                ],
              ),
              SizedBox(height: 15),
              // Second Row: 3 Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGridItem(context, "AI", "asset/AI.jpg", AiChatboxPage()),
                  SizedBox(width: 15),
                  _buildGridItem(context, "Course Books", "asset/course_books.jpg", CourseBooksPage()),
                  SizedBox(width: 15),
                  _buildGridItem(context, "Timetable", "asset/timetable.jpg", TimetableApp()),
                ],
              ),
              SizedBox(height: 15),
              // Third Row: 2 Boxes Centered
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGridItem(context, "Home Activities", "asset/home.jpg", HomeActivitiesPage()),
                  SizedBox(width: 15),
                  _buildGridItem(context, "Past Papers", "asset/pp.jpg", PastPapersPage()),
                  SizedBox(width: 15),
                  _buildGridItem(context, "Announcements", "asset/anoun.jpg", AnnouncementsPage()),
                ],
              ),
              SizedBox(height: 15),
              // Fourth Row: 2 Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google Classroom Button with Logo
                  Container(
                    width: 170,  // Adjusted the width of the GCR button box
                    height: 170,  // Ensured the height fits nicely for the button
                    decoration: BoxDecoration(
                      color: Colors.white,  // White background for the box
                      borderRadius: BorderRadius.circular(8),  // Rounded corners (like your other boxes)
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,  // Transparent background for the button, so the container's background shows
                        shadowColor: Colors.transparent,  // Remove shadow to maintain consistency
                      ),
                      onPressed: _navigateToClassroom,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,  // Center the content vertically
                        crossAxisAlignment: CrossAxisAlignment.center,  // Center the content horizontally
                        children: [
                          Image.asset(
                            "asset/gcr_logo.jpg",  // Your GCR logo
                            height: 40,  // Adjust the height of the logo to fit within the box
                          ),
                          SizedBox(height: 10),  // Add space between the logo and text
                          Text(
                            'Google Classroom',
                            style: TextStyle(
                              color: Color(0xFF036AA4),  // Blue text color, similar to your design
                              fontWeight: FontWeight.bold,
                              fontSize: 14,  // Adjust the font size to fit better in the box
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 20), // Increased space between the GCR button and dictionary button

                  // Dictionary Page Button
                  _buildGridItem(
                    context,
                    "Dictionary",
                    "asset/dictionary.jpg", // Ensure this icon exists
                    dictionaryPage(), // Navigate to the Dictionary page (make sure to define the page properly)
                  ),
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }

  // Grid item widget to create the clickable boxes
  Widget _buildGridItem(BuildContext context, String title, String imagePath, Widget targetPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage));
      },
      child: Container(
        width: 170, // Fixed width
        height: 170, // Fixed height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 40), // Image size
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF036AA4)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Navigation drawer widget
  Widget _buildNavigationDrawer(BuildContext context) {
    return Container(
      color: Color(0xFF036AA4),
      child: ListView(
        children: [
          _buildNavItem(context, "Home", Icons.home, HomePage()),
          _buildNavItem(context, "Timetable", Icons.schedule, TimetableApp()),
          _buildNavItem(context, "Course Guide", Icons.book, CourseGuidePage()),
          _buildNavItem(context, "Course Books", Icons.menu_book, CourseBooksPage()),
          _buildNavItem(context, "Home Activities", Icons.home, HomeActivitiesPage()),
          _buildNavItem(context, "Past Papers", Icons.quiz, PastPapersPage()),
          _buildNavItem(context, "Dictionary", Icons.book, dictionaryPage()),
          _buildNavItem(context, "Notepad", Icons.note, NotepadPage1()),
          _buildNavItem(context, "AI", Icons.book, AiChatboxPage()),
          _buildNavItem(context, "Complaints", Icons.report_problem, ComplaintsScreen()),
          _buildNavItem(context, "Announcements", Icons.announcement, AnnouncementsPage()),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text("Logout", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdScreen()));
            },
          ),
        ],
      ),
    );
  }

  // Helper function to create navigation items
  Widget _buildNavItem(BuildContext context, String title, IconData icon, Widget targetPage) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage));
      },
    );
  }
}