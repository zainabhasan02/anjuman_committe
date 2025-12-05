import 'dart:async';
import 'dart:convert';

import 'package:anjuman_committee/core/theme/colours/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

class MyHook extends HookWidget {
  const MyHook({super.key});

  @override
  Widget build(BuildContext context) {
    // State Hooks
    final users = useState<List<dynamic>>([]);
    final isLoading = useState(true);

    final counter = useState(0);
    final textController = useTextEditingController();

    // Define fetchUsers function so it can be called from useEffect AND the Refresh button
    Future<void> fetchUsers() async {
      isLoading.value = true;
      debugPrint('Fetching users started...');
      try {
        final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/users'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'User-Agent': 'AnjumanCommitteeApp/1.0.0',
          },
        );
        if (response.statusCode == 200) {
          users.value = json.decode(response.body);
          debugPrint('Users fetched successfully: ${users.value.length}');
        } else {
          debugPrint('Failed to fetch users: ${response.statusCode}');
          debugPrint('Response body: ${response.body}');
        }
      } catch (e) {
        debugPrint('Error fetching users: $e');
      } finally {
        isLoading.value = false;
      }
    }

    // useEffects -> Work like a lifecycle ---> initState(), dispose()
    useEffect(() {
      fetchUsers();

      Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        counter.value = timer.tick;
        textController.text = counter.value.toString();
      });

      return () {
        timer.cancel();
      };
    }, []);

    return Scaffold(
      backgroundColor: AppColors.pastelSnow,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDemoSection(counter.value, textController),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'User Directory',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                if (isLoading.value)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  users.value.isEmpty && !isLoading.value
                      ? Center(
                        child: Text(
                          'No users found',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      )
                      : ListView.separated(
                        itemCount: users.value.length,
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final user = users.value[index];
                          return _buildUserCard(user);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoSection(int count, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.oliveGreen.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.timer_outlined,
                  color: AppColors.oliveGreen,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Active Timer',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '$count seconds',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller,
            readOnly: true,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              labelText: 'Auto-updating Value',
              labelStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: AppColors.pastelSnow,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(
                Icons.data_usage_rounded,
                color: Colors.grey,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(dynamic user) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.pastelPurple.withOpacity(0.15),
                  child: Text(
                    user['name'][0].toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.pastelPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 14,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              user['email'],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
