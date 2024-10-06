import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_weather/common/common_modal.dart';
import 'package:the_weather/common/custom_app_bar.dart';
import 'package:the_weather/common/weather_text.dart';
import 'package:the_weather/models/crop.dart';
import 'package:the_weather/packages/bottom_navigator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen> {
  List<Widget> getCropsInformation() {
    return Crop.generateCropsList().map((crop) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return CommonModal(
                  crop.name,
                  crop.information,
                  image: Image.asset(crop.imageUrl),
                  primaryButton: ModalButton("Got it", "", () {
                    Navigator.of(context).pop(); // Close the modal
                  }),
                );
              },
            );
          },
          child: Container(
            height: 150,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(crop.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Hey, Farmer!',
        disableLeading: true,
      ),
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
          child: SizedBox(
            height: 205,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeatherText.title("About Us", fontWeight: FontWeight.w700),
                const SizedBox(height: 12),
                WeatherText.body(
                    "We are a team of developers passionate about creating user-friendly apps that assist farmers in optimizing water management for their crops. Our app integrates meteorological data from reliable sources and combines it with specific crop water usage information. As a result, we are able to provide precise irrigation recommendations, helping farmers make informed decisions."),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 4.0),
          child: Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: getCropsInformation(),
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
          child: SizedBox(
            height: 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeatherText.title(
                    "Crops need water for transpiration and evaporation",
                    fontWeight: FontWeight.w700),
                const SizedBox(height: 12),
                WeatherText.title(
                  "Transpiration",
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
                const SizedBox(height: 12),
                WeatherText.body(
                    "The plant roots suck or extract water from the soil to live and grow. The main part of this water does not remain in the plant, but escapes to the atmosphere as vapour through the plant's leaves and stem. This process is called transpiration. Transpiration happens mainly during the day time."),
                const SizedBox(height: 12),
                WeatherText.title(
                  "Evaporation",
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
                const SizedBox(height: 12),
                WeatherText.body(
                    "Water from an open water surface escapes as vapour to the atmosphere during the day. The same happens to water on the soil surface and to water on the leaves and stem of a plant"),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 4.0),
          child: SizedBox(
            height: 850,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeatherText.title("Factors that influence crop water needs",
                    fontWeight: FontWeight.w700),
                const SizedBox(height: 12),
                WeatherText.title(
                  "The Influence of the climate on crop water needs",
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
                const SizedBox(height: 12),
                WeatherText.body(
                    "A certain crop grown in a sunny and hot climate needs per day more water than the same crop grown in a cloudy and cooler climate. There are, however - apart from sunshine and temperature - other climatic factors which influence the crop water need. These factors are the humidity and the windspeed. When it is dry, the crop water needs are higher than when it is humid. In windy climates the crops will use more water than in calm climates."),
                const SizedBox(height: 12),
                WeatherText.title(
                  "The Influence of the crop type on the crop water needs",
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
                const SizedBox(height: 12),
                WeatherText.body(
                    "The crop type has an influence on the daily water needs of a fully grown crop; i.e. the peak daily water needs: a fully developed maize crop will need more water per day than a fully developed crop of onions."),
                const SizedBox(height: 12),
                WeatherText.title(
                  "The Influence of the growth stage of the crop on crop water needs",
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
                const SizedBox(height: 12),
                WeatherText.body(
                    "A fully grown maize crop will need more water than a maize crop which has just been planted."),
                const SizedBox(height: 12),
                WeatherText.body(
                    "At planting and during the initial stage, the evaporation is more important than the transpiration and the evapotranspiration or crop water need during the initial stage is estimated at 50 percent of the crop water need during the mid - season stage, when the crop is fully developed."),
                const SizedBox(height: 12),
                WeatherText.body(
                    "During the so-called crop development stage the crop water need gradually increases from 50 percent of the maximum crop water need to the maximum crop water need. The maximum crop water need is reached at the end of the crop development stage which is the beginning of the mid-season stage."),
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: const BottomNavigator(),
    );
  }
}
