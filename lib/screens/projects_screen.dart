
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'project_details_screen.dart';
import 'new_project_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _selectedStatus = 'Current';
  String _selectedFilter = 'All';

  final List<ProjectItem> _projects = [
    ProjectItem(
      name: 'Rose Bloom Tote',
      progress: 68,
      status: 'In Progress',
      deadline: 'Nov 12',
      color: const Color(0xFFE9B3C0),
      icon: Icons.shopping_bag_outlined,
      category: 'Bags',
      difficulty: 'Intermediate',
      description: 'A beautiful handmade crochet tote bag.',
    ),
    ProjectItem(
      name: 'Baby Blanket',
      progress: 35,
      status: 'In Progress',
      deadline: 'Dec 1',
      color: const Color(0xFFFFF0E8),
      icon: Icons.grid_view_rounded,
      category: 'Home Decor',
      difficulty: 'Beginner',
      description: 'A soft and cozy handmade baby blanket.',
    ),
    ProjectItem(
      name: 'Bunny Amigurumi',
      progress: 10,
      status: 'Planned',
      deadline: 'Dec 20',
      color: const Color(0xFFB9CBB5),
      icon: Icons.cruelty_free_outlined,
      category: 'Toys',
      difficulty: 'Intermediate',
      description: 'A cute handmade crochet bunny.',
    ),
    ProjectItem(
      name: 'Flower Bouquet',
      progress: 100,
      status: 'Completed',
      deadline: 'Oct 10',
      color: const Color(0xFFE3C9A8),
      icon: Icons.local_florist,
      category: 'Flowers',
      difficulty: 'Beginner',
      description: 'A lovely handmade crochet flower bouquet.',
    ),
    ProjectItem(
      name: 'Crochet Scarf',
      progress: 100,
      status: 'Completed',
      deadline: 'Sep 15',
      color: const Color(0xFFE9B3C0),
      icon: Icons.checkroom_outlined,
      category: 'Accessories',
      difficulty: 'Beginner',
      description: 'A warm and comfortable crochet scarf.',
    ),
  ];

  List<ProjectItem> get _filteredProjects {
    return _projects.where((project) {
      final isCompleted = project.status == 'Completed';

      final matchesStatus = _selectedStatus == 'Current'
          ? !isCompleted
          : isCompleted;

      final matchesFilter = _selectedFilter == 'All' ||
          project.status == _selectedFilter;

      return matchesStatus && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final projects = _filteredProjects;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screen heading
              const Text(
                'My Projects',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Every little stitch brings you closer.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                ),
              ),

              const SizedBox(height: 22),

              // Current and completed tabs
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    _statusButton('Current'),
                    _statusButton('Completed'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Filter heading
              const Text(
                'Filter Projects',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),

              const SizedBox(height: 12),

              // Filter chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'All',
                  'In Progress',
                  'Planned',
                  'On Hold',
                ].map((filter) {
                  final selected = _selectedFilter == filter;

                  return ChoiceChip(
                    label: Text(filter),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.white,
                    side: BorderSide.none,
                    labelStyle: TextStyle(
                      color: selected
                          ? AppColors.white
                          : AppColors.darkBrown,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // Project list heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Creations',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  Text(
                    '${projects.length} projects',
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Project cards
              if (projects.isEmpty)
                _emptyState()
              else
                ...projects.map(_projectCard),

              const SizedBox(height: 22),

              // New project button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _showNewProjectScreen,
                  icon: const Icon(Icons.add),
                  label: const Text('New Project'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Current / Completed button
  Widget _statusButton(String status) {
    final selected = _selectedStatus == status;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedStatus = status;
            _selectedFilter = 'All';
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Text(
            status,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected
                  ? AppColors.white
                  : AppColors.secondaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // Individual project card
  Widget _projectCard(ProjectItem project) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: project.color.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  project.icon,
                  size: 38,
                  color: AppColors.darkBrown,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      project.status,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.secondaryText,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Target: ${project.deadline}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.secondaryText,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '${project.category} • ${project.difficulty}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 17),

          // Progress information
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Progress',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkBrown,
                ),
              ),

              Text(
                '${project.progress}%',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 9),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: project.progress / 100,
              minHeight: 8,
              backgroundColor: AppColors.cream,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 12),

          // View details button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                _showProjectDetails(project);
              },
              child: const Text(
                'View Project →',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Empty project message
  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 50,
            color: AppColors.primary,
          ),

          SizedBox(height: 12),

          Text(
            'No projects found',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: AppColors.darkBrown,
            ),
          ),

          SizedBox(height: 6),

          Text(
            'Try another filter or create a new project.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  // Open New Project screen and receive the new project
  Future<void> _showNewProjectScreen() async {
    final newProject = await Navigator.push<ProjectItem>(
      context,
      MaterialPageRoute(
        builder: (context) => const NewProjectScreen(),
      ),
    );

    if (!mounted) return;

    if (newProject != null) {
      setState(() {
        _projects.insert(0, newProject);
        _selectedStatus = 'Current';
        _selectedFilter = 'All';
      });
    }
  }

  // Open Project Details screen
  void _showProjectDetails(ProjectItem project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ProjectDetailsScreen(
            project: project,
          );
        },
      ),
    );
  }
}

// Project data model
class ProjectItem {
  final String name;
  final int progress;
  final String status;
  final String deadline;
  final Color color;
  final IconData icon;
  final String category;
  final String difficulty;
  final String description;

  ProjectItem({
    required this.name,
    required this.progress,
    required this.status,
    required this.deadline,
    required this.color,
    required this.icon,
    this.category = 'Other',
    this.difficulty = 'Beginner',
    this.description = '',
  });
}
