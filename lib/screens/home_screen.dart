
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Good morning, Tashu 🌷",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBrown,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Ready to create something lovely?",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.cream,
                    child: Icon(
                      Icons.notifications_none,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your cozy corner",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Make Something\nLovely ✨",
                      style: TextStyle(
                        fontSize: 27,
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Explore Patterns"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              
              _sectionTitle("Continue Creating"),
              const SizedBox(height: 14),

              _projectCard(
                "Rose Bloom Tote",
                "68%",
                0.68,
                "Continue your lovely project",
              ),
              const SizedBox(height: 12),
              _projectCard(
                "Baby Blanket",
                "35%",
                0.35,
                "Keep going, you're doing great!",
              ),

              const SizedBox(height: 28),

            
              _sectionTitle("Your Crochet Tools"),
              const SizedBox(height: 14),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.6,
                children: [
                  _toolCard(Icons.inventory_2_outlined, "Yarn Inventory"),
                  _toolCard(Icons.exposure_plus_1, "Row Counter"),
                  _toolCard(Icons.palette_outlined, "Color Studio"),
                  _toolCard(Icons.calculate_outlined, "Cost Calculator"),
                ],
              ),

              const SizedBox(height: 28),

              
              _sectionTitle("Beginner-Friendly Patterns"),
              const SizedBox(height: 14),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.local_florist,
                        size: 30,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cute Crochet Flowers",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.darkBrown,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Perfect for beginners",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Learning Section
              _sectionTitle("Learn Something New"),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: _learningCard(
                      Icons.school_outlined,
                      "Learn Crochet",
                      "Start learning",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _learningCard(
                      Icons.auto_awesome,
                      "Tutorial Simplifier",
                      "Understand patterns",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: AppColors.darkBrown,
      ),
    );
  }

  Widget _projectCard(
      String name,
      String percentage,
      double progress,
      String subtitle,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.cream,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 7),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              percentage,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolCard(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 27, color: AppColors.primary),
          const SizedBox(height: 9),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBrown,
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _learningCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: AppColors.primary),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.darkBrown,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
