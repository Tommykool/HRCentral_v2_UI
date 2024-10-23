import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrcentral_v2_ui/Components/BottomNavBarWidget.dart';

class SettingPageWidget extends StatefulWidget {
  const SettingPageWidget({super.key});

  @override
  State<SettingPageWidget> createState() => _SettingPageWidgetState();
}

class _SettingPageWidgetState extends State<SettingPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF14181B),
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pushNamed('/home'),
          ),
          title: const Text(
            'Setting',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFF14181B),
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Account'),
                    _buildSettingItem(
                      icon: Icons.person,
                      title: 'Edit Profile',
                    ),
                    _buildSettingItem(
                      icon: Icons.attach_money_rounded,
                      title: 'Payment Options',
                    ),
                    _buildSettingItem(
                      icon: Icons.language_outlined,
                      title: 'Country',
                    ),
                    _buildSettingItem(
                      icon: Icons.notifications_none,
                      title: 'Notification Settings',
                    ),
                    _buildSectionHeader('General'),
                    _buildSettingItem(
                      icon: Icons.help_outline,
                      title: 'Support',
                    ),
                    _buildSettingItem(
                      icon: Icons.info_outline,
                      title: 'Terms of Service',
                    ),
                    _buildSettingItem(
                      icon: Icons.lock_outline,
                      title: 'Privacy Policy',
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomNavBarWidget(
                  onItemSelected: (String routeName) {
                    context.go(routeName); // Use go_router to navigate
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          color: Color(0xFF57636C),
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
  Widget _buildSettingItem({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Color(0x3416202A),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                icon,
                color: const Color(0xFF57636C),
                size: 24,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF14181B),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF57636C),
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}