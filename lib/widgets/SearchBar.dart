import 'package:flutter/material.dart';

import '../view/search_screen.dart';

class MySearchBar extends StatefulWidget {
  final String? query;

  const MySearchBar({super.key, this.query});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // If query is passed, set it to the controller
    if (widget.query != null) {
      _controller.text = widget.query!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                icon: Icon(Icons.search, color: Colors.black54),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.black45),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              final query = _controller.text.trim();
              if (query.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(query: _controller.text),
                  ),
                );
              }
            },
            child: const Icon(Icons.arrow_forward, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

// Example SearchResultsPage
class SearchResultsPage extends StatelessWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    // You can use the query here to call the API
    return Scaffold(
      appBar: AppBar(title: Text('Results for "$query"')),
      body: Center(child: Text('Show results for: $query')),
    );
  }
}
