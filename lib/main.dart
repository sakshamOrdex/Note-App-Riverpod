import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/addPage.dart';
import 'package:myapp/editPage.dart';
import 'package:myapp/state_notifier.dart';
import 'package:myapp/theme_provider.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider); 
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode, 
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providers = ref.watch(noteProvider);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade200,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              themeNotifier.toggleTheme();
            },
          ),
        ],
      ),
      body: providers.isEmpty
          ? Center(
              child: Text(
                "No Items yet!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            )
          : Container(
              child: ListView.builder(
                itemCount: providers.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        providers[index].title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        providers[index].content,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              final note = providers[index];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditPage(
                                    id: note.id,
                                    title: note.title,
                                    content: note.content,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(noteProvider.notifier)
                                  .delete(providers[index].id);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addpage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
