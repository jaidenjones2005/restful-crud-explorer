
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'album.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RESTful CRUD Explorer',
      home: const AlbumListScreen(),
    );
  }
}

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({super.key});

  @override
  State<AlbumListScreen> createState() =>
      _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  late Future<List<Album>> futureAlbums;

  Album? selectedAlbum;
  bool isDeleting = false;

  // Tracks albums removed during this session
  final Set<int> deletedAlbumIds = {};

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbums();
  }

  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((json) => Album.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  void selectAlbum(Album album) {
    if (isDeleting) return;

    setState(() {
      selectedAlbum = album;
    });
  }

  Future<void> deleteAlbum() async {
    if (selectedAlbum == null || isDeleting) return;

    final album = selectedAlbum!;

    setState(() {
      isDeleting = true;
    });

    try {
      final response = await http.delete(
        Uri.parse(
          'https://jsonplaceholder.typicode.com/albums/${album.id}',
        ),
      );

      if (response.statusCode == 200) {
        if (!mounted) return;

        setState(() {
          deletedAlbumIds.add(album.id);
          selectedAlbum = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Album deleted successfully!'),
          ),
        );
      } else {
        throw Exception(
          'Failed to delete album. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isDeleting = false;
        });
      }
    }
  }

  Widget buildSelectedAlbumView() {
    if (selectedAlbum == null) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'No Album Selected',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selected Album Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('Album ID: ${selectedAlbum!.id}'),
            Text('User ID: ${selectedAlbum!.userId}'),
            Text('Title: ${selectedAlbum!.title}'),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: isDeleting ? null : deleteAlbum,
              icon: const Icon(Icons.delete),
              label: Text(
                isDeleting ? 'Deleting...' : 'Delete Album',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RESTful CRUD Explorer'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          buildSelectedAlbumView(),

          Expanded(
            child: FutureBuilder<List<Album>>(
              future: futureAlbums,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                    ),
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No albums found'),
                  );
                }

                final albums = snapshot.data!
                    .where(
                      (album) =>
                  !deletedAlbumIds.contains(album.id),
                )
                    .toList();

                if (albums.isEmpty) {
                  return const Center(
                    child: Text('No albums remaining'),
                  );
                }

                return ListView.builder(
                  itemCount: albums.length,
                  itemBuilder: (context, index) {
                    final album = albums[index];

                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${album.id}'),
                      ),
                      title: Text(album.title),
                      subtitle: Text(
                        'Album ID: ${album.id}',
                      ),
                      selected: selectedAlbum?.id == album.id,
                      onTap: () {
                        selectAlbum(album);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
