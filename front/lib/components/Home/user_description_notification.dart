import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/user_bloc.dart'; // Adjust with your actual bloc file
import 'package:food_delivery_app/blocs/user_state.dart';
// import 'package:food_delivery_app/models/user.dart'; // Update with your user model

class UserDescriptionAndNotification extends StatelessWidget {
  const UserDescriptionAndNotification(
      {Key? key, required String userName, required String profileImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserAuthenticated) {
          return _buildUserCard(context, state.user.fullname);
        } else if (state is UserError) {
          return _buildErrorCard(context, state.error);
        } else {
          return _buildLoadingCard(context);
        }
      },
    );
  }

  Widget _buildUserCard(BuildContext context, String userName) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: AssetImage('images/user.jpg'), // Placeholder image
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome,",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                userName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.notifications,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorCard(BuildContext context, String message) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Center(
        child: Text(
          "Error: $message",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
