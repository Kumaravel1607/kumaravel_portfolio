import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const MyElitePortfolio());
}

class MyElitePortfolio extends StatelessWidget {
  const MyElitePortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kumaravel Shanmugam | Senior Flutter Developer',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF020408),
        primaryColor: Colors.blueAccent,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const PortfolioHome(),
    );
  }
}

class MajorProject {
  final String title;
  final String description;
  final String role;
  final String imageUrl;
  final List<String> tech;
  final String? playStoreUrl;

  MajorProject({
    required this.title,
    required this.description,
    required this.role,
    required this.imageUrl,
    required this.tech,
    this.playStoreUrl,
  });
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _keys = List.generate(7, (index) => GlobalKey());

  void _scrollTo(int index) {
    Scrollable.ensureVisible(
      _keys[index].currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutExpo,
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 900;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(isMobile),
      drawer: isMobile ? _buildDrawer() : null,
      body: Stack(
        children: [
          Positioned(
            top: -150,
            right: -100,
            child: _auraGlow(Colors.blue.withOpacity(0.2), 600),
          ),
          Positioned(
            bottom: 100,
            left: -100,
            child: _auraGlow(Colors.indigo.withOpacity(0.15), 500),
          ),

          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildHero(isMobile),
                _buildBentoProfile(isMobile, width, _keys[0]),
                _buildSkillsCategorized(isMobile, width, _keys[1]),
                _buildMajorCaseStudies(isMobile, width, _keys[2]),
                _buildExperienceAndEducation(isMobile, width, _keys[3]),
                _buildContactSection(_keys[5]),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isMobile) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        backgroundColor: Colors.black.withOpacity(0.2),
        elevation: 0,
        title: Text(
          "KUMARAVEL SHANMUGAM",
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 2,
          ),
        ),
        actions: isMobile
            ? null
            : [
                _navBtn("Profile", 0),
                _navBtn("Skills", 1),
                _navBtn("Work", 2),
                _navBtn("Experience", 3),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ElevatedButton(
                    onPressed: () => _scrollTo(5),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text("Contact"),
                  ),
                ),
                const SizedBox(width: 40),
              ],
      ),
    );
  }

  Widget _navBtn(String text, int index) {
    return TextButton(
      onPressed: () => _scrollTo(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildHero(bool isMobile) {
    return Container(
      height: 850,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _glassBadge("4.4 YEARS OF MOBILE ARCHITECTURE"),
          const SizedBox(height: 30),
          Text(
            "Kumaravel Shanmugam\nFlutter Architect.",
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 48 : 95,
              fontWeight: FontWeight.w800,
              height: 1.0,
              letterSpacing: -3,
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
          const SizedBox(height: 30),
          const Text(
            "Dharmapuri, Tamil Nadu • Specialized in high-performance Flutter Apps",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 50),
          _glassButton(
            "View Case Studies",
            () => _scrollTo(2),
            Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildBentoProfile(bool isMobile, double width, GlobalKey key) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: 50,
      ),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          _bentoBox(
            width: isMobile ? width : width * 0.55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "OVERVIEW",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 15),

                // ✅ UPDATED PROFESSIONAL SUMMARY
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Text(
                    "Results-driven Senior Flutter Developer with over 4 years of experience in designing and developing high-performance, scalable mobile applications. Proficient in building cross-platform solutions using Flutter, with a strong focus on clean architecture, performance optimization, and user-centric design.\n\nExperienced in delivering end-to-end mobile solutions, collaborating with cross-functional teams, and translating business requirements into technical implementations.",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: isMobile ? 16 : 20,
                      fontWeight: FontWeight.w500,
                      height: 1.7,
                    ),
                  ),
                ),
              ],
            ),
          ),

          _bentoBox(
            width: isMobile ? width : width * 0.25,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "4.4",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                Text(
                  "Years of Experience",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsCategorized(bool isMobile, double width, GlobalKey key) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel("TECHNICAL TOOLKIT"),
          const SizedBox(height: 40),
          _responsiveRow(isMobile, [
            _skillGroup("Flutter Core", [
              "Flutter SDK",
              "Dart",
              "Firebase",
              "Sqflite",
            ]),
            _skillGroup("State Management", ["BLoC", "Provider", "Riverpod"]),
            _skillGroup("Design & Web", ["Figma", "PHP (Basic)", "HTML/CSS"]),
            _skillGroup("Payments & Fintech", [
              "Razorpay Payment Gateway Integration",
              "ICICI Bank API (UPI & Payment Services)",
              "Secure Transaction Handling & Validation",
            ]),
          ]),
        ],
      ),
    );
  }

  Widget _buildMajorCaseStudies(bool isMobile, double width, GlobalKey key) {
    List<MajorProject> products = [
      MajorProject(
        title: "Digital Gold & Silver Smart Saving App",
        description:
            "A digital gold and silver investment platform that enables users to buy, sell, and track live metal rates with secure saving schemes and jewellery store integration.",
        role:
            "Lead Flutter Developer: Built the real-time gold and silver rate sync engine, scheme management system, and integrated secure payment gateways for digital metal investments.",
        imageUrl: "assets/images/SS.png",
        tech: ["Flutter", "Firebase", "REST API", "State Management"],
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.witvotech.ssjewellery",
      ),

      MajorProject(
        title: "Witvo POS Offline",
        description:
            "A cross-platform Point-of-Sale (POS) system designed for small and medium-scale businesses, supporting mobile, tablet, and Windows devices. It enables billing, inventory management, and transaction processing even in offline mode with seamless web-based data synchronization when connectivity is restored.",
        role:
            "Architecture Specialist: Designed an offline-first Sqflite database architecture with background sync mechanisms, ensuring real-time web-based data synchronization and consistent business operations across mobile, tablet, and Windows platforms.",
        imageUrl: "assets/images/POS.png",
        tech: [
          "Flutter",
          "Sqflite",
          "Offline Sync",
          "REST API",
          "Windows Support",
          "Multi-Device Architecture",
        ],
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.witvotech.witvoposoffline",
      ),

      MajorProject(
        title: "Kshatriya People Connect",
        description:
            "A multi-purpose community platform supporting matrimony, business networking, finance services, and education-based engagement within a unified ecosystem.",
        role:
            "Full Stack App Developer: Developed community feed, membership verification system, and real-time notification modules supporting multi-domain services.",
        imageUrl: "assets/images/KPC.png",
        tech: ["Flutter", "Riverpod", "Firebase Cloud Messaging", "JSON APIs"],
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.jambu.kshatriyapeopleconnect",
      ),
      MajorProject(
        title: "Business Expense Manager (Internal Project)",
        description:
            "A personal and business finance tracking application designed to manage daily expenses, categorize transactions, and generate simple financial summaries for individuals and small businesses. (Not published on Play Store)",
        role:
            "Flutter Developer: Built complete expense tracking system with local storage, category-wise analytics, and clean UI for managing personal and business expenditures.",
        imageUrl: "assets/images/BIZ.png",
        tech: ["Flutter", "Local Storage", "Sqflite", "State Management"],
        playStoreUrl: "",
      ),
    ];
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: 100,
      ),
      child: Column(
        children: [
          _sectionLabel("LIVE ON PLAY STORE"),
          const SizedBox(height: 60),
          ...products.map((p) => _buildCaseStudyItem(p, isMobile)).toList(),
          _sectionLabel("OTHER CONTRIBUTIONS"),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              "Business Expense Manager",
              "Membership Association App",
              "Learning Management System (LMS)",
            ].map((e) => _chip(e)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCaseStudyItem(MajorProject p, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Container(
              height: 520,
            decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(30),
  image: DecorationImage(
    image: AssetImage(p.imageUrl),
    fit: BoxFit.cover,
  ),
  border: Border.all(color: Colors.white10),
),
            ),
          ),
          if (!isMobile) const SizedBox(width: 80),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isMobile) const SizedBox(height: 30),
                Text(
                  p.title,
                  style: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _smallLabel("THE PROJECT"),
                Text(
                  p.description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 25),
                _smallLabel("MY ROLE"),
                Text(
                  p.role,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: p.tech.map((t) => _techChip(t)).toList(),
                ),
                const SizedBox(height: 40),
                if (p.playStoreUrl != null)
                  _storeBtn(
                    const FaIcon(FontAwesomeIcons.googlePlay),
                    "Get it on Play Store",
                    () => _launchUrl(p.playStoreUrl!),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceAndEducation(
    bool isMobile,
    double width,
    GlobalKey key,
  ) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel("EXPERIENCE"),
          const SizedBox(height: 40),
          _expItem(
            "Senior Flutter Developer",
            "Witvo Technologies Pvt Ltd",
            "March 2024 - Present",
            "Pochampalli, Krishnagiri",
          ),
          _expItem(
            "Software Developer",
            "Hashref Technologies",
            "Jan 2022 - March 2024",
            "Dharmapuri",
          ),
        ],
      ),
    );
  }

  // --- UI COMPONENTS & FIXES ---

  Widget _expItem(String t, String c, String d, String loc) => Padding(
    padding: const EdgeInsets.only(bottom: 40),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.work_history_outlined,
          color: Colors.blueAccent,
          size: 28,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                c,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              Text(
                "$d • $loc",
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _skillGroup(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ...items.map(
          (i) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              "• $i",
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  // FIXED: Accepts IconData (which FaIconData extends)
  // Change the parameter type to IconData (which covers both standard and FA icons)
  Widget _storeBtn(Widget icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme(
              data: const IconThemeData(color: Colors.black, size: 20),
              child: icon,
            ),
            const SizedBox(width: 15),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bentoBox({required double width, required Widget child}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: child,
    );
  }

  Widget _techChip(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.white10),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    ),
  );

  Widget _chip(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    margin: const EdgeInsets.only(right: 10, bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.03),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white10),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),
  );

  Widget _sectionLabel(String text) => Text(
    text,
    style: const TextStyle(
      color: Colors.blueAccent,
      fontWeight: FontWeight.bold,
      fontSize: 13,
      letterSpacing: 3,
    ),
  );

  Widget _smallLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
        fontSize: 11,
        letterSpacing: 2,
      ),
    ),
  );

  Widget _glassButton(String text, VoidCallback onTap, Color color) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _auraGlow(Color color, double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [BoxShadow(color: color, blurRadius: 150, spreadRadius: 50)],
    ),
  );

  Widget _glassBadge(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.blueAccent,
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    ),
  );

  Widget _buildContactSection(GlobalKey key) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [
          Text(
            "Ready for the next big thing?",
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 40,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 40),
          _bentoBox(
            width: 600,
            child: Column(
              children: [
                // EMAIL
                _contactRow(
                  iconWidget: const Icon(
                    Icons.mail_outline,
                    color: Color(0xFF3B82F6),
                    size: 22,
                  ),
                  title: "Email",
                  value: "kumaravelshanmugam98@gmail.com",
                  onTap: () =>
                      _launchUrl("mailto:kumaravelshanmugam98@gmail.com"),
                ),
                const Divider(height: 40, color: Colors.white10),

                // PHONE
                _contactRow(
                  iconWidget: const Icon(
                    Icons.phone_iphone,
                    color: Color(0xFF3B82F6),
                    size: 22,
                  ),
                  title: "Phone",
                  value: "+91 9976850646",
                  onTap: () => _launchUrl("tel:+919976850646"),
                ),
                const Divider(height: 40, color: Colors.white10),

                // LINKEDIN (Using FaIcon for FontAwesome)
                _contactRow(
                  iconWidget: const FaIcon(
                    FontAwesomeIcons.linkedinIn,
                    color: Color(0xFF3B82F6),
                    size: 20,
                  ),
                  title: "LinkedIn",
                  value: "Kumaravel Shanmugam",
                  onTap: () => _launchUrl(
                    "https://www.linkedin.com/in/kumaravel-shanmugam-338154179?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app",
                  ),
                ),
                const Divider(height: 40, color: Colors.white10),

                // INSTAGRAM
                _contactRow(
                  iconWidget: const Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xFF3B82F6),
                    size: 22,
                  ),
                  title: "Instagram",
                  value: "kums_joshi_29",
                  onTap: () =>
                      _launchUrl("https://instagram.com/kums_joshi_29"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- REUSABLE CLICKABLE ROW ---
  Widget _contactRow({
    required Widget iconWidget, // Accepts any Icon or FaIcon widget
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: iconWidget), // Icon is centered here
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.white24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 60),
    child: Center(
      child: Text(
        "Built with Flutter • Dharmapuri • © 2024",
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    ),
  );

  Widget _responsiveRow(bool isMobile, List<Widget> children) {
    if (isMobile)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children
            .map(
              (e) =>
                  Padding(padding: const EdgeInsets.only(bottom: 50), child: e),
            )
            .toList(),
      );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children.map((e) => Expanded(child: e)).toList(),
    );
  }

  Widget _buildDrawer() => Drawer(
    backgroundColor: const Color(0xFF020408),
    child: ListView(
      children: [
        const DrawerHeader(child: Center(child: Text("MENU"))),
        ListTile(
          title: const Text("Profile"),
          onTap: () {
            Navigator.pop(context);
            _scrollTo(0);
          },
        ),
        ListTile(
          title: const Text("Skills"),
          onTap: () {
            Navigator.pop(context);
            _scrollTo(1);
          },
        ),
        ListTile(
          title: const Text("Work"),
          onTap: () {
            Navigator.pop(context);
            _scrollTo(2);
          },
        ),
        ListTile(
          title: const Text("Experience"),
          onTap: () {
            Navigator.pop(context);
            _scrollTo(3);
          },
        ),
      ],
    ),
  );
}
