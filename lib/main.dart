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
      title: 'Kumaravel Shanmugam | Senior Flutter Engineer',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF030712),
        primaryColor: const Color(0xFF3B82F6),
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
  final String badge;
  final String description;
  final String role;
  final List<String> images;
  final List<String> tech;
  final List<String> keyFeatures;
  final String? playStoreUrl;

  MajorProject({
    required this.title,
    required this.badge,
    required this.description,
    required this.role,
    required this.images,
    required this.tech,
    required this.keyFeatures,
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
  // 5 navigation sections: [0: Profile, 1: Skills, 2: Work, 3: Experience, 4: Contact]
  final List<GlobalKey> _keys = List.generate(5, (index) => GlobalKey());

  void _scrollTo(int index) {
    Scrollable.ensureVisible(
      _keys[index].currentContext!,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 960;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(isMobile),
      drawer: isMobile ? _buildDrawer() : null,
      body: Stack(
        children: [
          // Dynamic Ambient Glows
          Positioned(
            top: -160,
            right: -100,
            child: _auraGlow(const Color(0xFF3B82F6).withValues(alpha: 
              0.18), 650),
          ),
          Positioned(
            top: 600,
            left: -120,
            child: _auraGlow(const Color(0xFF8B5CF6).withValues(alpha: 0.12), 600),
          ),
          Positioned(
            bottom: 300,
            right: -80,
            child: _auraGlow(const Color(0xFF06B6D4).withValues(alpha: 0.10), 550),
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
                _buildContactSection(_keys[4]),
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
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: AppBar(
            backgroundColor: const Color(0xFF030712).withValues(alpha: 0.65),
            elevation: 0,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blueAccent.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.code,
                    size: 14,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "KUMARAVEL SHANMUGAM",
                  style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            actions: isMobile
                ? null
                : [
                    _navBtn("Profile", 0),
                    _navBtn("Skills", 1),
                    _navBtn("Work", 2),
                    _navBtn("Experience", 3),
                    const SizedBox(width: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: ElevatedButton(
                        onPressed: () => _scrollTo(4),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Contact",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
          ),
        ),
      ),
    );
  }

  Widget _navBtn(String text, int index) {
    return TextButton(
      onPressed: () => _scrollTo(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildHero(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 120 : 160,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _glassBadge("⚡ 4+ YEARS OF FLUTTER EXCELLENCE"),
          const SizedBox(height: 30),
          Text(
            "Kumaravel Shanmugam\nSenior Flutter Engineer.",
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 42 : 82,
              fontWeight: FontWeight.w800,
              height: 1.05,
              letterSpacing: -2,
            ),
          ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.15),
          const SizedBox(height: 25),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              "Specialized in high-performance cross-platform Flutter applications, offline-first architectures, POS hardware integrations, and fintech systems.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                color: Colors.white60,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _glassButton(
                "Explore Case Studies",
                () => _scrollTo(2),
                const Color(0xFF3B82F6),
              ),
              OutlinedButton(
                onPressed: () => _scrollTo(4),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 22,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Get in Touch",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBentoProfile(bool isMobile, double width, GlobalKey key) {
    return Container(
      key: key,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 40,
      ),
      child: Wrap(
        spacing: 24,
        runSpacing: 24,
        children: [
          _bentoBox(
            width: isMobile ? width : width * 0.58,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionLabel("PROFESSIONAL SUMMARY"),
                const SizedBox(height: 20),
                Text(
                  "Results-driven Senior Flutter Developer with 4+ years of hands-on experience in architecting, developing, and shipping enterprise-grade cross-platform mobile and desktop systems.\n\nDemonstrated expertise in building resilient offline-first architectures, automated cloud-sync engines, ESC/POS hardware interfaces, and secure payment workflows with clean modular state management.",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 15 : 18,
                    fontWeight: FontWeight.w400,
                    height: 1.7,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          _bentoBox(
            width: isMobile ? width : width * 0.32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _sectionLabel("EXPERIENCE HIGHLIGHT"),
                const SizedBox(height: 16),
                const Text(
                  "4+",
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF60A5FA),
                    height: 1.0,
                  ),
                ),
                const Text(
                  "Years Commercial Flutter Experience",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white10),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.blueAccent,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Dharmapuri, Tamil Nadu, India",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
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
        horizontal: isMobile ? 20 : 80,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel("TECHNICAL CAPABILITIES"),
          const SizedBox(height: 10),
          Text(
            "Toolkit & Engineering Stack",
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 40),
          _responsiveRow(isMobile, [
            _skillCard("Flutter Core", [
              "Flutter SDK (Mobile & Desktop)",
              "Dart Language & Concurrency",
              "Sqflite Local Relational DB",
              "Firebase Suite & FCM Push",
            ]),
            _skillCard("Architecture & State", [
              "BLoC Architecture Pattern",
              "Riverpod State Management",
              "Provider & Clean Architecture",
              "Offline-First Bidirectional Sync",
            ]),
            _skillCard("Hardware & POS", [
              "ESC/POS Thermal Printers",
              "Bluetooth / USB / Wi-Fi Interfaces",
              "Weighing Scale Integration",
              "Barcode & QR Label Printers",
            ]),
            _skillCard("Fintech & Payments", [
              "Razorpay Payment Gateway",
              "ICICI Bank API & UPI Services",
              "Split Payments (Cash / Card / UPI)",
              "Secure MPIN & Auth Flow",
            ]),
          ]),
        ],
      ),
    );
  }

  Widget _buildMajorCaseStudies(bool isMobile, double width, GlobalKey key) {
    final List<MajorProject> products = [
      MajorProject(
        title: "Witvo Smart POS (Hybrid Online & Offline)",
        badge: "FLAGSHIP ENTERPRISE SYSTEM",
        description:
            "A high-speed Point-of-Sale (POS) and inventory platform built for retail businesses, restaurants, and supermarkets. Engineered with a resilient dual-mode architecture: runs 100% offline with zero-latency local billing, and automatically synchronizes sales, stock, and ledger data with web cloud servers upon network availability.",
        role:
            "Lead Systems Architect: Designed the offline-first Sqflite database sync pipeline, hardware printer drivers (2-inch / 3-inch Bluetooth, USB, Wi-Fi network printers), electronic weighing scale telemetry, bilingual catalog indexing (Tamil/English), and fast 4-digit MPIN cashier authentication.",
        images: [
          "assets/images/pos_dashboard.jpeg",
          "assets/images/pos_billing.jpeg",
          "assets/images/pos_thermal_print.jpeg",
          "assets/images/pos_reports.jpeg",
          "assets/images/pos_settings.jpeg",
        ],
        tech: [
          "Flutter",
          "Sqflite Offline Engine",
          "Automated Cloud Sync",
          "Bluetooth / USB Printing",
          "ESC/POS Thermal",
          "REST APIs",
          "Split Payments (UPI/Cash/Card)",
        ],
        keyFeatures: [
          "Offline-First & Auto Cloud Sync with Conflict Resolution",
          "Instant Thermal Invoice Printing (2\" / 3\" Rolls + A4)",
          "Multi-Tender Payments (UPI, Cash, Card) & Due Tracking",
          "Real-Time Sales, Profit, and Expense Analytics Reports",
          "Barcode/QR Scanning & Digital Weighing Scale Connect",
        ],
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.witvotech.witvoposoffline",
      ),
      MajorProject(
        title: "Digital Gold & Silver Smart Saving App",
        badge: "FINTECH & COMMODITIES",
        description:
            "A digital gold and silver micro-investment engine enabling users to purchase, liquidate, and monitor real-time precious metal rates with scheduled recurring saving schemes and jewelry store fulfillment.",
        role:
            "Lead Flutter Engineer: Implemented live bullion rate polling, scheme tenure calculations, secure customer KYC pipelines, and multi-gateway payment processing.",
        images: ["assets/images/SS.png"],
        tech: [
          "Flutter",
          "Firebase",
          "Real-Time Metal Engine",
          "REST API",
          "Clean Architecture",
        ],
        keyFeatures: [
          "Sub-second Live Gold & Silver Price Tracking",
          "Recurring Metal Savings Scheme Management",
          "Bank-grade Secure Transactions & Invoicing",
        ],
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.witvotech.ssjewellery",
      ),
      MajorProject(
        title: "Kshatriya People Connect",
        badge: "COMMUNITY PLATFORM",
        description:
            "A multi-tenant ecosystem combining verified matrimonial directories, business matchmaking, finance facilitation, and localized community broadcasts.",
        role:
            "Full Stack Mobile Developer: Developed dynamic community feed, background push notifications with FCM, encrypted chat modules, and membership verification.",
        images: ["assets/images/KPC.png"],
        tech: ["Flutter", "Riverpod", "Firebase Cloud Messaging", "JSON APIs"],
        keyFeatures: [
          "Identity & Community Verification Gateway",
          "Integrated Matrimony & Business Networking",
          "High-throughput Push Notifications",
        ],
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.jambu.kshatriyapeopleconnect",
      ),
      MajorProject(
        title: "Business Expense Manager",
        badge: "INTERNAL TOOL",
        description:
            "A comprehensive offline ledger application created for small enterprise owners to track expenditures, generate cashflow summaries, and export category-wise tax statements.",
        role:
            "Sole Developer: Handled UI/UX prototyping, Sqflite schema design, and PDF/Excel financial report generators.",
        images: ["assets/images/BIZ.png"],
        tech: ["Flutter", "Sqflite", "State Management", "PDF Export"],
        keyFeatures: [
          "Zero Cloud Latency - 100% Local Encrypted Database",
          "Monthly Spend Forecast & Category Breakdown",
        ],
        playStoreUrl: null,
      ),
    ];

    return Container(
      key: key,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel("FEATURED CASE STUDIES"),
          const SizedBox(height: 10),
          Text(
            "Production Systems & Apps",
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 60),
          ...products.map((p) => _buildCaseStudyItem(p, isMobile)),
          const SizedBox(height: 30),
          _sectionLabel("OTHER REPOSITORIES & CONTRIBUTIONS"),
          const SizedBox(height: 25),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              "Business Expense Ledger",
              "Association Membership Hub",
              "Learning Management System (LMS)",
              "Thermal ESC/POS Bluetooth Driver Library",
            ].map((e) => _chip(e)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCaseStudyItem(MajorProject p, bool isMobile) {
    return Container(
      margin: const EdgeInsets.only(bottom: 90),
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Interactive Carousel / Screenshot Showcase
          Expanded(
            flex: isMobile ? 0 : 5,
            child: ProjectImageCarousel(
              images: p.images,
              height: isMobile ? 420 : 560,
            ),
          ),
          SizedBox(width: isMobile ? 0 : 60, height: isMobile ? 40 : 0),
          // Right: Content Details
          Expanded(
            flex: isMobile ? 0 : 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _smallLabel(p.badge),
                const SizedBox(height: 8),
                Text(
                  p.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  p.description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.02),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "MY ARCHITECTURAL ROLE",
                        style: TextStyle(
                          color: Color(0xFF60A5FA),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        p.role,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "HIGHLIGHTS",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                ...p.keyFeatures.map(
                  (f) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "▹ ",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        Expanded(
                          child: Text(
                            f,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: p.tech.map((t) => _techChip(t)).toList(),
                ),
                const SizedBox(height: 35),
                if (p.playStoreUrl != null && p.playStoreUrl!.isNotEmpty)
                  _storeBtn(
                    const FaIcon(FontAwesomeIcons.googlePlay, size: 18),
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
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel("CAREER PATH"),
          const SizedBox(height: 10),
          Text(
            "Work Experience",
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 40),
          _expItem(
            role: "Senior Flutter Developer",
            company: "Witvo Technologies Pvt Ltd",
            duration: "March 2024 - Present",
            location: "Bengaluru, Karnataka",
            bullets: [
              "Architected cross-platform offline & online POS application supporting mobile, tablet, and Windows desktop.",
              "Implemented ESC/POS thermal printing routines via Bluetooth, USB, and Wi-Fi networks.",
              "Delivered full-cycle Flutter mobile solutions including digital gold savings and community networking apps.",
              "Integrated Razorpay and ICICI bank APIs for automated UPI settlement and secure checkout.",
           
              "Created asynchronous background synchronization engines maintaining high consistency with cloud inventory.",
            ],
          ),
        _expItem(
            role: "Software Developer (Flutter)",
            company: "Hashref Technologies",
            duration: "Jan 2022 - March 2024",
            location: "Dharmapuri, Tamil Nadu",
            bullets: [
              "Developed and maintained cross-platform Flutter applications including College Attendance Management, Learning Management Systems (LMS), and Real Estate platforms.",
              "Implemented scalable and maintainable state management architectures leveraging BLoC and Riverpod.",
            ],
          ),
        ],
      ),
    );
  }

  Widget _expItem({
    required String role,
    required String company,
    required String duration,
    required String location,
    required List<String> bullets,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 45),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.25)),
          ),
          child: const Icon(
            Icons.work_outline_rounded,
            color: Color(0xFF60A5FA),
            size: 24,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                role,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                company,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF60A5FA),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "$duration • $location",
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 12),
              ...bullets.map(
                (b) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• ", style: TextStyle(color: Colors.grey)),
                      Expanded(
                        child: Text(
                          b,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _skillCard(String title, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 18),
          ...items.map(
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: Color(0xFF60A5FA),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      i,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
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

  Widget _storeBtn(Widget icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme(
              data: const IconThemeData(color: Colors.black, size: 18),
              child: icon,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 14,
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
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: child,
    );
  }

  Widget _techChip(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
    ),
  );

  Widget _chip(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.03),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
    ),
  );

  Widget _sectionLabel(String text) => Text(
    text,
    style: const TextStyle(
      color: Color(0xFF60A5FA),
      fontWeight: FontWeight.w800,
      fontSize: 12,
      letterSpacing: 2.5,
    ),
  );

  Widget _smallLabel(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.blueAccent.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFF60A5FA),
        fontWeight: FontWeight.bold,
        fontSize: 10,
        letterSpacing: 1.5,
      ),
    ),
  );

  Widget _glassButton(String text, VoidCallback onTap, Color color) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 22),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
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
      boxShadow: [BoxShadow(color: color, blurRadius: 160, spreadRadius: 60)],
    ),
  );

  Widget _glassBadge(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Colors.blueAccent.withValues(alpha: 0.08),
      border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.25)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFF60A5FA),
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.8,
      ),
    ),
  );

  Widget _buildContactSection(GlobalKey key) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 20),
      child: Column(
        children: [
          _sectionLabel("LET'S CONNECT"),
          const SizedBox(height: 12),
          Text(
            "Ready to scale your next product?",
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 38,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 40),
          _bentoBox(
            width: 620,
            child: Column(
              children: [
                _contactRow(
                  iconWidget: const FaIcon(
                    FontAwesomeIcons.envelope,
                    color: Color(0xFF60A5FA),
                    size: 20,
                  ),
                  title: "Email",
                  value: "kumaravelshanmugam98@gmail.com",
                  onTap: () =>
                      _launchUrl("mailto:kumaravelshanmugam98@gmail.com"),
                ),
                const Divider(height: 36, color: Colors.white10),
                _contactRow(
                  iconWidget: const FaIcon(
                    FontAwesomeIcons.phone,
                    color: Color(0xFF60A5FA),
                    size: 20,
                  ),
                  title: "Phone",
                  value: "+91 9976850646",
                  onTap: () => _launchUrl("tel:+919976850646"),
                ),
                const Divider(height: 36, color: Colors.white10),
                _contactRow(
                  iconWidget: const FaIcon(
                    FontAwesomeIcons.linkedinIn,
                    color: Color(0xFF60A5FA),
                    size: 20,
                  ),
                  title: "LinkedIn",
                  value: "Kumaravel Shanmugam",
                  onTap: () => _launchUrl(
                    "https://in.linkedin.com/in/kumaravel-shanmugam-338154179",
                  ),
                ),
                const Divider(height: 36, color: Colors.white10),
                _contactRow(
                  iconWidget: const FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Color(0xFF60A5FA),
                    size: 20,
                  ),
                  title: "Instagram",
                  value: "@kums_joshi_ks",
                  onTap: () =>
                      _launchUrl("https://www.instagram.com/kums_joshi_ks/"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactRow({
    required Widget iconWidget,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.2)),
              ),
              child: Center(child: iconWidget),
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
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Colors.white24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 50),
    child: Center(
      child: Text(
        "Crafted with Flutter • Dharmapuri, India • © ${DateTime.now().year} Kumaravel Shanmugam",
        style: const TextStyle(color: Colors.white38, fontSize: 13),
      ),
    ),
  );

  Widget _responsiveRow(bool isMobile, List<Widget> children) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children
            .map(
              (e) =>
                  Padding(padding: const EdgeInsets.only(bottom: 20), child: e),
            )
            .toList(),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
          .map(
            (e) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: e,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDrawer() => Drawer(
    backgroundColor: const Color(0xFF030712),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Color(0xFF0F172A)),
          child: Center(
            child: Text(
              "PORTFOLIO MENU",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person_outline),
          title: const Text("Profile"),
          onTap: () {
            Navigator.pop(context);
            _scrollTo(0);
          },
        ),
        ListTile(
          leading: const Icon(Icons.bolt_outlined),
          title: const Text("Skills"),
          onTap: () {
            Navigator.pop(context);
            _scrollTo(1);
          },
        ),
        ListTile(
          leading: const Icon(Icons.apps_rounded),
          title: const Text("Work"),
          onTap: () {
            Navigator.pop(context);
            _scrollTo(2);
          },
        ),
        ListTile(
          leading: const Icon(Icons.work_outline),
          title: const Text("Experience"),
          onTap: () {
            Navigator.pop(context);
            _scrollTo(3);
          },
        ),
        ListTile(
          leading: const Icon(Icons.mail_outline),
          title: const Text("Contact"),
          onTap: () {
            Navigator.pop(context);
            _scrollTo(4);
          },
        ),
      ],
    ),
  );
}

/// --- INTERACTIVE IMAGE CAROUSEL COMPONENT ---
/// Displays images inside a sleek frame with page dot indicators and prev/next controls.
class ProjectImageCarousel extends StatefulWidget {
  final List<String> images;
  final double height;

  const ProjectImageCarousel({
    super.key,
    required this.images,
    required this.height,
  });

  @override
  State<ProjectImageCarousel> createState() => _ProjectImageCarouselState();
}

class _ProjectImageCarouselState extends State<ProjectImageCarousel> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white10,
        ),
      );
    }

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: const Color(0xFF030712),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (idx) {
                setState(() => _currentIndex = idx);
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  widget.images[index],
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF0F172A),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone_android_rounded,
                              size: 54,
                              color: Colors.blueAccent.withValues(alpha: 0.6),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Preview ${index + 1}",
                              style: const TextStyle(
                                color: Colors.white54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // Subtle Gradient Fade at the bottom for readability
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 70,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
                  ),
                ),
              ),
            ),

            // Prev / Next Floating Arrows
            if (widget.images.length > 1) ...[
              Positioned(
                left: 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black.withValues(alpha: 0.4),
                    ),
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black.withValues(alpha: 0.4),
                    ),
                    icon: const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ),
            ],

            // Indicator Dots
            if (widget.images.length > 1)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.images.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 6,
                      width: _currentIndex == i ? 22 : 6,
                      decoration: BoxDecoration(
                        color: _currentIndex == i
                            ? const Color(0xFF60A5FA)
                            : Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
