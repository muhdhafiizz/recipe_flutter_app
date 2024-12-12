import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recipe_flutter_app/ui/login/login_page.dart';
import 'package:recipe_flutter_app/ui/profile/profile_controller.dart';
import 'package:recipe_flutter_app/ui/widgets/drawer.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final controller = ProfileController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
      ),
      drawer: const Drawer(
        backgroundColor: Colors.brown,
        child: DrawerList(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: SizedBox(
                height: 250,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => context
                              .read<ProfileController>()
                              .updateProfilePicture(context),
                          child: Center(
                            child: Consumer<ProfileController>(
                              builder: (context, provider, child) {
                                return provider.profileImageUrl != null
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                            provider.profileImageUrl!),
                                      )
                                    : Container(
                                        height: 100,
                                        width: 100,
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.person),
                                      );
                              },
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .name,
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          user?.displayName ?? 'User',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!
                              .email,
                          style: const TextStyle(fontSize: 12),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user?.email ?? 'Not provided',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                                onTap: () {
                                  final email = user?.email ?? 'Not provided';
                                  Clipboard.setData(ClipboardData(text: email));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Email copied to clipboard'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.copy)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.translate, color: Colors.brown),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<ProfileController>(
                          builder: (context, controller, child) {
                            return Text(
                              controller.locale.languageCode == 'en'
                                  ? 'English'
                                  : 'Bahasa Malaysia',
                              style: const TextStyle(fontSize: 16.0),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        Consumer<ProfileController>(
                          builder: (context, controller, child) {
                            return ToggleSwitch(
                              fontSize: 16.0,
                              initialLabelIndex:
                                  controller.locale.languageCode == 'en'
                                      ? 0
                                      : 1,
                              activeBgColor: const [Colors.brown],
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.grey[900],
                              totalSwitches: 2,
                              labels: const ['EN', 'MS'],
                              onToggle: (index) {
                                if (index != null) {
                                  controller.switchLanguage(index);
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.brown),
                    title: Text(AppLocalizations.of(context)!.signOut),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
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
