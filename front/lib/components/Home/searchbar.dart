import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/product_bloc.dart';
import 'package:food_delivery_app/blocs/product_event.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({Key? key}) : super(key: key);

  @override
  _SearchBarComponentState createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  final TextEditingController _controller = TextEditingController();

  void _onSearch(String query) {
    BlocProvider.of<ProductsBloc>(context).add(SearchProducts(query));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Search Furniture",
                border: InputBorder.none,
              ),
              onSubmitted: _onSearch,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search,
                color: Theme.of(context).colorScheme.secondary),
            onPressed: () => _onSearch(_controller.text),
          ),
        ],
      ),
    );
  }
}
