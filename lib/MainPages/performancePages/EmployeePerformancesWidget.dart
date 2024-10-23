import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrcentral_v2_ui/API_Calls/employeeAPI_Calls/EmployeeDTO.dart';
import 'package:hrcentral_v2_ui/API_Calls/performanceAPI_Calls/PerformanceDTO.dart';
import 'package:hrcentral_v2_ui/API_Calls/performanceAPI_Calls/performanceAPI.dart';

class EmployeePerformancesWidget extends StatelessWidget {
  final EmployeeDTO employee;
  EmployeePerformancesWidget({required this.employee, super.key});
  final PerformanceAPIService api = PerformanceAPIService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            _buildPerformanceHistory(),
            Positioned(
              right: 16,
              bottom: 16,
              child: _buildAddReviewButton(context),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(160),
      child: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          title: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            context.go('/employeeProfile', extra: employee);
                          },
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Employee Details',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(7),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildInfoRow('Employee Name:', '${employee.firstName} ${employee.lastName}'),
                            SizedBox(height: 5),
                            _buildInfoRow('Job Position: ', employee.jobTitle),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          centerTitle: true,
          expandedTitleScale: 1.0,
        ),
        toolbarHeight: 160,
        elevation: 0,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildPerformanceHistory() {
    return FutureBuilder<List<PerformanceDTO>>(
      future: api.fetchPerformanceDatabyEmployeeId(employee.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No performance history found.'));
        } else {
          final performances = snapshot.data!;
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Performance History',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: performances.length,
                        itemBuilder: (context, index) {
                          final performance = performances[index];
                          return PerformanceCard(employee,performance,performance.createdAt.toString(), performance.reviewScore.toString());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }



  Widget _buildAddReviewButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        context.go('/createEmployeeReview',extra:employee);
      },
      label: Text('Add New Performance Review'),
      icon: Icon(Icons.add),
    );
  }
}

class PerformanceCard extends StatelessWidget{
 final PerformanceDTO performance;
 final EmployeeDTO employee;
 final String date;
 final String reviewScore;

 PerformanceCard(this.employee,this.performance, this.date, this.reviewScore);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          context.go(
            '/employeePerformanceDetail',
            extra: {
              'performance': performance,
              'employee': employee,
            },
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(date, style: TextStyle(color: Colors.grey[600])),
                  Text('Review Score', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    reviewScore,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}