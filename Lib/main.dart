import 'package:flutter/material.dart
void main() {
  runApp(const SonuApp());
}

class SonuApp extends StatelessWidget {
  const SonuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سونو',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF10111B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7567F8),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MusicHomePage(),
    );
  }
}

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  bool isPlaying = false;
  int selectedSong = 0;

  final List<Map<String, String>> songs = [
    {'title': 'أغنيتي الأولى', 'artist': 'سونو'},
    {'title': 'أغنيتي الثانية', 'artist': 'سونو'},
    {'title': 'أغنيتي الثالثة', 'artist': 'سونو'},
  ];

  @override
  Widget build(BuildContext context) {
    final song = songs[selectedSong];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('سونو', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              tooltip: 'بحث',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF29244D), Color(0xFF171827)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(
                  Icons.music_note_rounded,
                  size: 110,
                  color: Color(0xFFFFCC66),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                song['title']!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                song['artist']!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 20),
              Slider(
                value: 0,
                onChanged: (_) {},
                activeColor: const Color(0xFF9B8CFF),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedSong =
                            (selectedSong - 1 + songs.length) % songs.length;
                        isPlaying = false;
                      });
                    },
                    icon: const Icon(Icons.skip_previous_rounded),
                    iconSize: 38,
                  ),
                  const SizedBox(width: 16),
                  FilledButton(
                    onPressed: () => setState(() => isPlaying = !isPlaying),
                    style: FilledButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(18),
                    ),
                    child: Icon(
                      isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      size: 38,
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedSong = (selectedSong + 1) % songs.length;
                        isPlaying = false;
                      });
                    },
                    icon: const Icon(Icons.skip_next_rounded),
                    iconSize: 38,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'قائمة الأغاني',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    final item = songs[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF29244D),
                        child: Icon(
                          index == selectedSong && isPlaying
                              ? Icons.equalizer
                              : Icons.music_note,
                          color: const Color(0xFFFFCC66),
                        ),
                      ),
                      title: Text(item['title']!),
                      subtitle: Text(item['artist']!),
                      onTap: () {
                        setState(() {
                          selectedSong = index;
                          isPlaying = true;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
