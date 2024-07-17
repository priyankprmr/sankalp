import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Dispatch/Screens/create_dispatch_screen.dart';
import 'package:sankalp/Orders/Providers/order_list_provider.dart';
import 'package:sankalp/Orders/Widgets/order_card.dart';
import 'package:sankalp/Utils/string_const.dart';

class OrderList extends ConsumerStatefulWidget {
  const OrderList({super.key});

  @override
  ConsumerState<OrderList> createState() => _OrderListState();
}

class _OrderListState extends ConsumerState<OrderList> {
  TextEditingController queryController = TextEditingController();
  final ScrollController _controller = ScrollController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () {
        if (_controller.position.atEdge) {
          page++;
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        page = 1;
        setState(() {});
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: queryController,
            onChanged: (value) {
              setState(() {});
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: StringConst.searchAllOrders,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: ref.watch(
                orderListFutureProvider({
                  'search': queryController.text,
                  'page': page,
                }).future,
              ),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.none:
                    return const Center(
                      child: Text('Something went wrong!!!!'),
                    );
                  case ConnectionState.active:
                    return const Center();
                  case ConnectionState.done:
                    final data = snapshot.data ?? [];
                    return data.isEmpty
                        ? const Center(
                            child: Text(
                              'No data found',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textScaler: TextScaler.linear(1.0),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            controller: _controller,
                            padding: const EdgeInsets.only(bottom: 70),
                            itemBuilder: (BuildContext context, int index) {
                              final order = data.elementAt(index);
                              return OrderCard(order: order);
                            },
                          );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 60.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateDispatchScreen(),
                    ),
                  ).then(
                    (value) {
                      setState(() {});
                    },
                  );
                },
                child: const Text("Create dispatch"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
