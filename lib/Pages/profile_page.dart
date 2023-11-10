import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.maxFinite,
          color: Theme.of(context).colorScheme.inversePrimary,
          child: ListView(
            children: [
              SizedBox(
                height: 400,
                child: Text(
                  'ASDDSADASD',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(
                height: 400,
                child: Text(
                  'ASDDSADASD ',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(
                height: 400,
                child: Text(
                  'ASDDSADASD',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(
                height: 400,
                child: Text(
                  'ASDDSADASD',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(
                height: 400,
                child: Text(
                  'ASDDSADASD',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              )
            ],
          )),
    );
  }
}
