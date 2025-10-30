import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/authentication_view_model.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final subscriptionList = ref.watch(subscriptionListProvider );
    return Scaffold(
      appBar: AppBar(
        title: Text("Subscription List"),
      ),
      body: subscriptionList.when(
          data: (subscription){
            return ListView.builder(
              itemCount: subscription.length,
                itemBuilder: (context,index){
                final subscriptionIndex = subscription[index];
                return ListTile(
                  title: Text(subscriptionIndex.name??''),
                  leading: CircleAvatar(
                    child: Text(
                      ((int.tryParse(subscriptionIndex.id.toString()) ?? 0) ).toString(),
                    ),
                    
                  ),
                  subtitle: Text(subscriptionIndex.data?.capacity??"N/A"),
                );
                }
            );
          },
          error: (error,stack){
          debugPrint(error.toString());
            return Text(error.toString());
          }
          ,
          loading: ()=>Center(child: CircularProgressIndicator())
      ),
    );
  }
}
