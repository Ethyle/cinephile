import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'; 
import '../models/series_model.dart';
import '../models/episode_model.dart'; 
import '';
import '../ui/theme.dart'; 

class SeriesDetailsScreen extends StatefulWidget {
  final Series series;

  const SeriesDetailsScreen({Key? key, required this.series}) : super(key: key);

  @override
  State<SeriesDetailsScreen> createState() => _SeriesDetailsScreenState();
}

class _SeriesDetailsScreenState extends State<SeriesDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Widget _buildSeriesImage() {
    return Row(
      children: [
        Image.network(
          widget.series.imageUrl,
          width: 100,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.series.numberOfEpisodes} Épisodes',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Sortie: ${widget.series.releaseDate}',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.network(
              widget.series.imageUrl,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: Text(widget.series.title, style: TextStyle(color: Colors.white)),
              backgroundColor: AppColors.seeMoreBackground,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight + MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildSeriesImage(),
                  ),
                  _buildTabBar(),
                  Container(
                    height: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        HistoryTab(series: widget.series),
                        CharactersTab(series: widget.series),
                        EpisodesTab(series: widget.series),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: AppColors.orange,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white60,
      tabs: [
        Tab(text: 'Histoire'),
        Tab(text: 'Personnages'),
        Tab(text: 'Épisodes'),
      ],
    );
  }
}

class HistoryTab extends StatelessWidget {
  final Series series;

  const HistoryTab({Key? key, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.seeMoreBackground, // Set the background color to black
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: HtmlWidget(
          series.synopsis,
          textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class CharactersTab extends StatelessWidget {
  final Series series;

  const CharactersTab({Key? key, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.seeMoreBackground, // Set the background color to black
     child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: HtmlWidget(
          series.characterCredits,
          textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class EpisodesTab extends StatelessWidget {
  final Series series;

  const EpisodesTab({Key? key, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Episode> episodes = []; // Placeholder for your episodes list

    return Container(
      color: AppColors.seeMoreBackground, // Set the background color to black
      child: ListView.builder(
        itemCount: episodes.length,
        itemBuilder: (context, index) {
          return _buildCardItem(
            imageUrl: episodes[index].imageUrl,
            title: episodes[index].name,
            subtitle: episodes[index].airDate,
            context: context,
          );
        },
      ),
    );
  }
}

Widget _buildCardItem({
  required String imageUrl,
  required String title,
  String? subtitle,
  required BuildContext context,
}) {
  return Card(
    color: AppColors.cardBackground,
    child: ListTile(
      leading: Image.network(imageUrl, fit: BoxFit.cover),
      title: Text(title, style: TextStyle(color: Colors.white)),
      subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: Colors.white70)) : null,
    ),
  );
}

