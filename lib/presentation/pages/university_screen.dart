import 'package:country_state_city/models/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university_list/data/university_model.dart';
import 'package:university_list/data/university_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class UniversityScreen extends StatefulWidget {
  final Country country;
  const UniversityScreen({
    super.key,
    required this.country,
  });

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  late UniversityRepository _repository;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    _repository = UniversityRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Universities of ${widget.country.name}",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<List<UniversityModel>>(
        future: _repository.getUniversitiesByCountryName(
            countryName: widget.country.name),
        builder: (BuildContext context,
            AsyncSnapshot<List<UniversityModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CupertinoActivityIndicator(
                  radius: 50,
                  color: Theme.of(context).primaryColor,
                ),
              );
            case ConnectionState.none:
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            case ConnectionState.done:
              var universities = snapshot.data;

              if (universities?.isEmpty ?? true) {
                return const Center(
                  child: Text(
                    "No university found",
                  ),
                );
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  var university = universities[index];
                  return ListTile(
                    title: Text(university.name),
                    onTap: () {
                      if (university.webPages?.isNotEmpty ?? false) {
                        _launchInBrowser(
                          Uri.parse(university.webPages!.first),
                        );
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: universities!.length,
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
