
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentPortfolioApp());
}

const Color primaryBlue = Color(0xFF1746A2);
const Color lightBlue = Color(0xFFEAF2FF);
const Color backgroundColor = Color(0xFFF7F9FE);

class StudentPortfolioApp extends StatelessWidget {
  const StudentPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student E-Portfolio',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryBlue),
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFDCE4F3)),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// ---------------- LOGIN PAGE ----------------

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  void login() {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: const Column(
                        children: [
                          CircleAvatar(
                            radius: 42,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.school_rounded,
                              size: 48,
                              color: primaryBlue,
                            ),
                          ),
                          SizedBox(height: 18),
                          Text(
                            'STUDENT E-PORTFOLIO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Your journey. Your skills. Your future.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Welcome back!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign in to explore your portfolio.',
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 26),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email address',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        ).hasMatch(value.trim())) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must contain at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Demo login: enter any valid email and a password '
                      'of at least 6 characters.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- DASHBOARD ----------------

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeTab(),
    AboutTab(),
    SkillsTab(),
    ProjectsTab(),
    CertificatesTab(),
  ];

  final List<String> titles = [
    'My Portfolio',
    'About Me',
    'Technical Skills',
    'My Projects',
    'Certifications',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedIndex]),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'About',
          ),
          NavigationDestination(
            icon: Icon(Icons.code_outlined),
            selectedIcon: Icon(Icons.code),
            label: 'Skills',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: 'Projects',
          ),
          NavigationDestination(
            icon: Icon(Icons.workspace_premium_outlined),
            selectedIcon: Icon(Icons.workspace_premium),
            label: 'Certificates',
          ),
        ],
      ),
    );
  }
}

// ---------------- REUSABLE WIDGETS ----------------

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE3EAF7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: lightBlue,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: primaryBlue, size: 28),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  final List<Widget> children;

  const PortfolioPage({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: children,
    );
  }
}

// ---------------- TAB 1: HOME ----------------

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioPage(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [primaryBlue, Color(0xFF527FE5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 42,
                  color: primaryBlue,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Hello, I am',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'Katkuri Akshaya Reddy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Computer Science Engineering Student',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              SizedBox(height: 14),
              Text(
                'Learning, building, and growing one project at a time.',
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),
        const SectionTitle(
          title: 'Dashboard',
          subtitle: 'A quick overview of my academic journey.',
        ),
        const SizedBox(height: 16),
        const InfoCard(
          icon: Icons.school,
          title: 'Education',
          description: 'BVRIT Hyderabad College of Engineering for Women',
        ),
        const InfoCard(
          icon: Icons.star_outline,
          title: 'Academic Performance',
          description: 'CGPA: 9.38',
        ),
        const InfoCard(
          icon: Icons.terminal,
          title: 'Programming',
          description: 'Java, Python, C, and Data Structures and Algorithms',
        ),
        const InfoCard(
          icon: Icons.lightbulb_outline,
          title: 'Career Goal',
          description:
              'Build impactful software solutions and grow as a software engineer.',
        ),
      ],
    );
  }
}

// ---------------- TAB 2: ABOUT ----------------

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const PortfolioPage(
      children: [
        SectionTitle(
          title: 'About Me',
          subtitle: 'A little introduction.',
        ),
        SizedBox(height: 18),
        InfoCard(
          icon: Icons.person_outline,
          title: 'Who I Am',
          description:
              'I am Katkuri Akshaya Reddy, a Computer Science Engineering '
              'student at BVRIT Hyderabad College of Engineering for Women.',
        ),
        InfoCard(
          icon: Icons.school_outlined,
          title: 'College',
          description:
              'BVRIT Hyderabad College of Engineering for Women, Hyderabad.',
        ),
        InfoCard(
          icon: Icons.track_changes,
          title: 'My Objective',
          description:
              'To apply my programming and problem-solving skills to real-world '
              'challenges while continuously learning new technologies.',
        ),
        InfoCard(
          icon: Icons.favorite_outline,
          title: 'Interests',
          description:
              'Problem solving, software development, artificial intelligence, '
              'and learning new technologies.',
        ),
        InfoCard(
          icon: Icons.groups_outlined,
          title: 'Strengths',
          description:
              'Adaptability, teamwork, leadership, communication, and time management.',
        ),
      ],
    );
  }
}

// ---------------- TAB 3: SKILLS ----------------

class SkillsTab extends StatelessWidget {
  const SkillsTab({super.key});

  Widget skillGroup(String title, List<String> skills, IconData icon) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE3EAF7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: primaryBlue, size: 25),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills
                  .map(
                    (skill) => Chip(
                      label: Text(skill),
                      backgroundColor: lightBlue,
                      side: BorderSide.none,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PortfolioPage(
      children: [
        const SectionTitle(
          title: 'Technical Skills',
          subtitle: 'Tools and technologies I am learning and using.',
        ),
        const SizedBox(height: 18),
        skillGroup(
          'Programming Languages',
          ['Java', 'Python', 'C'],
          Icons.code,
        ),
        skillGroup(
          'Core Computer Science',
          ['Data Structures and Algorithms', 'OOP', 'DBMS'],
          Icons.memory,
        ),
        skillGroup(
          'Web Technologies',
          ['HTML', 'CSS', 'JavaScript', 'Flask'],
          Icons.web,
        ),
        skillGroup(
          'Databases',
          ['SQLite', 'SQL'],
          Icons.storage,
        ),
        skillGroup(
          'Tools and Platforms',
          ['Git', 'GitHub', 'VS Code', 'Eclipse', 'Tableau'],
          Icons.build_outlined,
        ),
        skillGroup(
          'Soft Skills',
          [
            'Problem Solving',
            'Teamwork',
            'Communication',
            'Leadership',
            'Adaptability',
          ],
          Icons.groups_outlined,
        ),
      ],
    );
  }
}

// ---------------- TAB 4: PROJECTS ----------------

class ProjectsTab extends StatelessWidget {
  const ProjectsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const PortfolioPage(
      children: [
        SectionTitle(
          title: 'My Projects',
          subtitle: 'A selection of projects from my learning journey.',
        ),
        SizedBox(height: 18),
        InfoCard(
          icon: Icons.analytics_outlined,
          title: 'Macro AI Credit Risk Assessment Model',
          description:
              'Developed an AI-powered credit risk assessment system to '
              'classify loan applicants into low- and high-risk categories '
              'using financial data.\n\n'
              'Technologies: Python, Flask, Scikit-learn, SQLite, Pandas, NumPy.',
        ),
        InfoCard(
          icon: Icons.devices_outlined,
          title: 'Smart Remote System',
          description:
              'Built a GUI-based Python application to remotely control '
              'household devices by simulating basic IoT functionality.\n\n'
              'Technologies: Python, Tkinter.',
        ),
        InfoCard(
          icon: Icons.account_balance_wallet_outlined,
          title: 'Payment State Doctor',
          description:
              'A payment-state analysis dashboard that identifies transaction '
              'issues and explains possible recovery actions.\n\n'
              'Technologies: Python, Streamlit.',
        ),
      ],
    );
  }
}

// ---------------- TAB 5: CERTIFICATES ----------------

class CertificatesTab extends StatelessWidget {
  const CertificatesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const PortfolioPage(
      children: [
        SectionTitle(
          title: 'Certifications',
          subtitle: 'Courses, credentials, and achievements.',
        ),
        SizedBox(height: 18),
        InfoCard(
          icon: Icons.workspace_premium,
          title: 'CodeChef: Data Structures',
          description:
              'Certificate of Completion\n'
              'Course: CS302PC: Data Structures\n'
              'Issued: 28 November 2025\n'
              'Certificate ID: e458b42\n'
              'Username: husk_fawn_25',
        ),
        InfoCard(
          icon: Icons.code,
          title: 'CodeChef: Java',
          description:
              'Java certification, November 2025.',
        ),
        InfoCard(
          icon: Icons.emoji_events_outlined,
          title: 'Smart India Hackathon 2025',
          description:
              'Qualified in the internal selection round at college.',
        ),
        InfoCard(
          icon: Icons.groups_outlined,
          title: 'Flipkart GRiD 7.0',
          description:
              'Participated in Flipkart’s engineering challenge.',
        ),
        InfoCard(
          icon: Icons.computer_outlined,
          title: 'Google Big Code',
          description:
              'Participated in a coding competition.',
        ),
        InfoCard(
          icon: Icons.volunteer_activism_outlined,
          title: 'COPE Certification',
          description:
              'Mental health awareness and related volunteering experience.',
        ),
      ],
    );
  }
}
