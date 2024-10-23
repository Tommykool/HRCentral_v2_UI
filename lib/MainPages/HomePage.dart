import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:hrcentral_v2_ui/API_Calls/ExcludeAPIs/openWebLink.dart';
import 'package:hrcentral_v2_ui/Components/BottomNavBarWidget.dart';
import 'package:hrcentral_v2_ui/Login&LogoutPages/loginPages/SignInPage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // Set light mode
      ThemeMode.light;
    });
  }  // A list of widgets corresponding to each tab
  final List<Widget> _pages = [
    const SignInPage(),
     HomePage(),
   // const SettingsPage(),
  ];

  int _selectedIndex = 1; // Default to 'Home' page
  // Handles tab selection
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: const Color(0xFF3977F6),
          automaticallyImplyLeading: true,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'HR-Central',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: const [
            Icon(
              Icons.notifications_sharp,
              color: Colors.white,
              size: 30,
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.person_sharp,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildFeatureCard(
                                context,
                                Icons.people,
                                'Employees',
                                    () {
                                      context.go('/employeesPage');
                                },
                              ),
                              _buildFeatureCard(
                                context,
                                Icons.laptop_mac,
                                'Performance Management',
                                    () {
                                  // Navigate to Performance Management
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildFeatureCard(
                                context,
                                Icons.description,
                                'Gantt Chart',
                                    () {
                                      openWebLink('https://www.onlinegantt.com');
                                },
                              ),
                              _buildFeatureCard(
                                context,
                                Icons.notifications,
                                'Announcements',
                                    () {
                                  // Navigate to Announcements
                                },
                              ),
                            ],
                          ),
                        ),
                        _buildRecentActivityCard(context),
                        _buildUpcomingEventsCard(context),
                        _buildQuickStatsCard(context),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(padding: const EdgeInsets.only(bottom: 20.0),
                child: BottomNavBarWidget(
                      onItemSelected: (String routeName) {
                        context.go(routeName); // Use go_router to navigate
                      },
                    ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.42,
          height: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12), // Reduced padding
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).iconTheme.color,
                  size: 30, // Slightly reduced icon size
                ),
                const SizedBox(height: 6), // Reduced spacing
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivityCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Material(
        color: Colors.transparent,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Activity',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'New employee onboarding: Sarah Johnson',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Leave request approved: Mike Smith',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Payroll processed for June 2024',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingEventsCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Events',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).primaryColor,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.event,
                    color: Theme.of(context).hintColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Team Meeting - Today, 2:00 PM',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: Theme.of(context).hintColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Project Deadline - Tomorrow',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStatsCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quick Stats',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.person_outline,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildStatCard(
                context,
                'Leave Balance',
                '12 days',
                const Color(0xFFE0F0FF),
                Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 20),
              _buildStatCard(
                context,
                'Tasks Completed',
                '8/10',
                const Color(0xFFE0FFE0),
                Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, Color backgroundColor, Color valueColor) {
    return Container(
      width: 150,
      height: 80,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).hintColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: valueColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
