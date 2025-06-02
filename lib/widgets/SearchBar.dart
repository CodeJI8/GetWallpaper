import 'package:flutter/material.dart';
import 'package:getx/view/search_screen.dart';
import '../controller/api.dart';

class MySearchBar extends StatefulWidget {
  final String query;
  MySearchBar({super.key, required this.query});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  late TextEditingController _controller;
  List<dynamic> searchResults = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.query);
    searchWallpapers(widget.query); // initial search
  }

  Future<void> searchWallpapers(String query) async {
    setState(() {
      isLoading = true;
    });

    try {
      // final results = await ApiClient.searchWallpapers(query);
      setState(() {
        // searchResults = results;
      });
    } catch (e) {
      // You can show an error message here
      setState(() {
        searchResults = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Row(
          children: [
            Expanded( // ✅ Fix: Add Expanded to provide width constraint
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.black12),
                ),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    searchWallpapers(value.trim());
                  },
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search, color: Colors.black54),
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.black45),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Show loading or results
        if (isLoading)
          const CircularProgressIndicator()
        else if (searchResults.isNotEmpty)
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final photo = searchResults[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    photo.src ?? "", // Replace with appropriate URL field
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          )
        else
          const Text('No results found.'),
      ],
    );
  }

}
