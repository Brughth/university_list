import 'package:country_state_city/models/country.dart';
import 'package:country_state_city/utils/country_utils.dart';
import 'package:flutter/material.dart';
import 'package:university_list/presentation/pages/university_screen.dart';

class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({super.key});

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Select Country",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<List<Country>>(
        future: getAllCountries(),
        builder: (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.none:
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            case ConnectionState.done:
              var countries = snapshot.data;

              if (countries?.isEmpty ?? true) {
                return const Center(
                  child: Text(
                    "No Country yet",
                  ),
                );
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  var country = countries[index];
                  return ListTile(
                    title: Text(country.name),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return UniversityScreen(country: country);
                          },
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: countries!.length,
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
