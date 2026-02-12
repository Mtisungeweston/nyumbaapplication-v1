import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../data/test_data.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final role = authProvider.userRole;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('Nyumba Dashboard'),
            actions: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => Navigator.pushNamed(context, '/profile'),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WelcomeSection(authProvider: authProvider),
                const SizedBox(height: 24),
                
                if (role == 'tenant') _TenantDashboard(authProvider: authProvider),
                if (role == 'landlord') _LandlordDashboard(authProvider: authProvider),
                if (role == 'agent') _AgentDashboard(authProvider: authProvider),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WelcomeSection extends StatelessWidget {
  final AuthProvider authProvider;

  const _WelcomeSection({required this.authProvider});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 18) {
      return 'Good Afternoon';
    } else if (hour >= 18 && hour < 24) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.primaryColor.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getGreeting(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${authProvider.userName}!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Role: ${authProvider.userRole.toUpperCase()}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class _TenantDashboard extends StatelessWidget {
  final AuthProvider authProvider;

  const _TenantDashboard({required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle('Quick Actions'),
        const SizedBox(height: 12),
        
        _ActionButton(
          title: 'Browse Properties',
          icon: Icons.search,
          onTap: () => Navigator.pushNamed(context, '/properties'),
        ),
        const SizedBox(height: 12),
        
        _ActionButton(
          title: 'Saved Properties',
          icon: Icons.favorite,
          onTap: () => Navigator.pushNamed(context, '/saved-properties'),
        ),
        const SizedBox(height: 12),
        
        _ActionButton(
          title: 'My Applications',
          icon: Icons.description,
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Applications feature coming soon')),
          ),
        ),
        const SizedBox(height: 24),

        _SectionTitle('Featured Properties'),
        const SizedBox(height: 12),
        
        ..._buildFeaturedProperties(context),
      ],
    );
  }

  List<Widget> _buildFeaturedProperties(BuildContext context) {
    final featured = mockProperties.where((p) => p['featured'] == true).take(2).toList();
    return featured.map((property) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _PropertyPreview(property: property),
      );
    }).toList();
  }
}

class _LandlordDashboard extends StatelessWidget {
  final AuthProvider authProvider;

  const _LandlordDashboard({required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle('Your Properties'),
        const SizedBox(height: 12),
        
        _ActionButton(
          title: 'Add New Property',
          icon: Icons.add_home,
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add property feature coming soon')),
          ),
        ),
        const SizedBox(height: 12),
        
        _ActionButton(
          title: 'View All Listings',
          icon: Icons.list,
          onTap: () => Navigator.pushNamed(context, '/properties'),
        ),
        const SizedBox(height: 12),
        
        _ActionButton(
          title: 'Tenant Inquiries',
          icon: Icons.mail,
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Inquiries feature coming soon')),
          ),
        ),
        const SizedBox(height: 24),

        _SectionTitle('Statistics'),
        const SizedBox(height: 12),
        
        Row(
          children: [
            _StatCard(label: 'Properties', value: '3'),
            const SizedBox(width: 12),
            _StatCard(label: 'Views', value: '245'),
          ],
        ),
      ],
    );
  }
}

class _AgentDashboard extends StatelessWidget {
  final AuthProvider authProvider;

  const _AgentDashboard({required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle('Your Listings'),
        const SizedBox(height: 12),
        
        _ActionButton(
          title: 'Browse Properties',
          icon: Icons.search,
          onTap: () => Navigator.pushNamed(context, '/properties'),
        ),
        const SizedBox(height: 12),
        
        _ActionButton(
          title: 'My Clients',
          icon: Icons.people,
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Clients management coming soon')),
          ),
        ),
        const SizedBox(height: 12),
        
        _ActionButton(
          title: 'Commission Tracking',
          icon: Icons.trending_up,
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Commission tracking coming soon')),
          ),
        ),
        const SizedBox(height: 24),

        _SectionTitle('Recent Activities'),
        const SizedBox(height: 12),
        
        _ActivityItem(
          title: 'Property Viewed',
          description: 'Modern Apartment in Lilongwe',
          time: '2 hours ago',
        ),
        const SizedBox(height: 12),
        
        _ActivityItem(
          title: 'Client Inquiry',
          description: 'About Spacious Family Home',
          time: '5 hours ago',
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.borderColor),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primaryColor),
            const SizedBox(width: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward, color: AppTheme.textSecondary),
          ],
        ),
      ),
    );
  }
}

class _PropertyPreview extends StatelessWidget {
  final Map<String, dynamic> property;

  const _PropertyPreview({required this.property});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/property-details', arguments: property),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.borderColor),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                property['image'],
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 150,
                  color: AppTheme.backgroundColor,
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property['name'],
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    property['location'],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'MWK ${property['price'].toString()}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
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

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;

  const _ActivityItem({
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.borderColor),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
