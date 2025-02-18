import 'package:expandable_box_drawing_table/models/entry.dart';
import 'package:expandable_box_drawing_table/models/expandable_box_drawing_table_configuration.dart';
import 'package:expandable_box_drawing_table/models/section.dart';
import 'package:expandable_box_drawing_table/widgets/expandable_box_drawing_table.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expandable Box Drawing Table Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Expandable Box Drawing Table'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isUsingCustomConfiguration = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            final sharedPreferences = snapshot.data;
            if (snapshot.hasData && sharedPreferences != null) {
              if (sharedPreferences.getStringList('enabled_cities') == null) {
                sharedPreferences.setStringList('enabled_cities', []);
              }

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Using custom configuration'),
                      Switch(
                        value: isUsingCustomConfiguration,
                        onChanged: (value) {
                          setState(() {
                            isUsingCustomConfiguration = value;
                          });
                        },
                      ),
                      SizedBox(width: 24.0),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  const TabBar(
                    tabs: [
                      Tab(text: 'Cities Example'),
                      Tab(text: 'Numbers Example'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _CitiesExpandableBoxDrawingTable(
                          isUsingCustomConfiguration:
                              isUsingCustomConfiguration,
                          sharedPreferences: sharedPreferences,
                        ),
                        _NumbersExpandableBoxDrawingTable(
                          isUsingCustomConfiguration:
                              isUsingCustomConfiguration,
                          sharedPreferences: sharedPreferences,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class _CitiesExpandableBoxDrawingTable extends StatelessWidget {
  const _CitiesExpandableBoxDrawingTable(
      {super.key,
      required this.isUsingCustomConfiguration,
      required this.sharedPreferences});
  final bool isUsingCustomConfiguration;
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 24.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: ExpandableBoxDrawingTable<String>(
          configuration: isUsingCustomConfiguration
              ? const ExpandableBoxDrawingTableConfigurationData(
                  sectionsHaveCheckBoxes: false,
                  entriesHaveCheckBoxes: true,
                  expandedIcon: Icons.catching_pokemon,
                  collapsedIcon: Icons.bubble_chart_outlined,
                )
              : ExpandableBoxDrawingTableConfigurationData
                  .defaultConfiguration(),
          initialValues:
              sharedPreferences.getStringList('enabled_cities') ?? [],
          onValuesChanged: (values) {
            sharedPreferences.setStringList('enabled_cities', values);
          },
          sections: [
            Section(
              title: 'Canada',
              subSections: [
                Section(
                  title: 'Alberta',
                  entries: [Entry(title: 'Calgary', value: 'calgary')],
                ),
                Section(
                  title: 'British Columbia',
                  entries: [
                    Entry(title: 'Vancouver', value: 'vancouver'),
                  ],
                ),
                Section(
                  title: 'Manitoba',
                  entries: [Entry(title: 'Winnipeg', value: 'winnipeg')],
                ),
                Section(
                  title: 'New Brunswick',
                  entries: [Entry(title: 'Moncton', value: 'moncton')],
                ),
                Section(
                  title: 'Newfoundland and Labrador',
                  entries: [Entry(title: 'St. Johns', value: 'stjohns')],
                ),
                Section(
                  title: 'Nova Scotia',
                  entries: [Entry(title: 'Halifax', value: 'halifax')],
                ),
                Section(
                  title: 'Northwest Territories',
                  entries: [
                    Entry(title: 'Yellowknife', value: 'yellowknife'),
                  ],
                ),
                Section(
                  title: 'Nunavut',
                  entries: [Entry(title: 'Iqaluit', value: 'iqaluit')],
                ),
                Section(
                  title: 'Ontario',
                  entries: [Entry(title: 'Toronto', value: 'toronto')],
                ),
                Section(
                  title: 'Prince Edward Island',
                  entries: [
                    Entry(title: 'Charlottetown', value: 'charlottetown'),
                  ],
                ),
                Section(
                  title: 'Quebec',
                  entries: [Entry(title: 'Montreal', value: 'montreal')],
                ),
                Section(
                  title: 'Saskatchewan',
                  entries: [
                    Entry(title: 'Saskatoon', value: 'saskatoon'),
                  ],
                ),
                Section(
                  title: 'Yukon',
                  entries: [
                    Entry(title: 'Whitehorse', value: 'whitehorse'),
                  ],
                ),
              ],
            ),
            Section(
              title: 'United States',
              subSections: [
                Section(
                  title: 'Alabama',
                  entries: [
                    Entry(title: 'Huntsville', value: 'huntsville'),
                    Entry(title: 'Birmingham', value: 'birmingham'),
                    Entry(title: 'Montgomery', value: 'montgomery'),
                    Entry(title: 'Mobile', value: 'mobile'),
                  ],
                ),
                Section(
                  title: 'Alaska',
                  entries: [
                    Entry(title: 'Anchorage', value: 'anchorage'),
                  ],
                ),
                Section(
                  title: 'Arizona',
                  entries: [
                    Entry(title: 'Tucson', value: 'tucson'),
                    Entry(title: 'Mesa', value: 'mesa'),
                    Entry(title: 'Chandler', value: 'chandler'),
                    Entry(title: 'Gilbert', value: 'gilbert'),
                    Entry(title: 'Glendale', value: 'glendale'),
                    Entry(title: 'Scottsdale', value: 'scottsdale'),
                    Entry(title: 'Peoria', value: 'peoria'),
                    Entry(title: 'Tempe', value: 'tempe'),
                    Entry(title: 'Surprise', value: 'surprise'),
                    Entry(title: 'Goodyear', value: 'goodyear'),
                    Entry(title: 'Buckeye', value: 'buckeye'),
                    Entry(title: 'Yuma', value: 'yuma'),
                  ],
                ),
                Section(
                  title: 'Arkansas',
                  entries: [
                    Entry(title: 'Little Rock', value: 'littlerock'),
                    Entry(title: 'Fayetteville', value: 'fayetteville'),
                  ],
                ),
                Section(
                  title: 'California',
                  entries: [
                    Entry(title: 'Los Angeles', value: 'los angeles'),
                    Entry(title: 'San Diego', value: 'san diego'),
                    Entry(title: 'San Jose', value: 'sanjose'),
                    Entry(title: 'San Francisco', value: 'sanfrancisco'),
                    Entry(title: 'Fresno', value: 'fresno'),
                    Entry(title: 'Sacramento', value: 'sacramento'),
                    Entry(title: 'Long Beach', value: 'longbeach'),
                    Entry(title: 'Oakland', value: 'oakland'),
                    Entry(title: 'Bakersfield', value: 'bakersfield'),
                    Entry(title: 'Anaheim', value: 'anaheim'),
                    Entry(title: 'Stockton', value: 'stockton'),
                    Entry(title: 'Riverside', value: 'riverside'),
                    Entry(title: 'Irvine', value: 'irvine'),
                    Entry(title: 'Santa Ana', value: 'santaana'),
                    Entry(title: 'Chula Vista', value: 'chulavista'),
                    Entry(title: 'Fremont', value: 'fremont'),
                    Entry(title: 'Santa Clarita', value: 'santaclarita'),
                    Entry(title: 'San Bernardino', value: 'sanbernardino'),
                    Entry(title: 'Modesto', value: 'modesto'),
                    Entry(title: 'Fontana', value: 'fontana'),
                    Entry(title: 'Moreno Valley', value: 'morenovalley'),
                    Entry(title: 'Oxnard', value: 'oxnard'),
                    Entry(title: 'Huntington Beach', value: 'huntingtonbeach'),
                    Entry(title: 'Glendale', value: 'glendaleca'),
                    Entry(title: 'Ontario', value: 'ontario'),
                    Entry(title: 'Elk Grove', value: 'elkgrove'),
                    Entry(title: 'Santa Rosa', value: 'santarosa'),
                    Entry(title: 'Rancho Cucamonga', value: 'ranchocucamonga'),
                    Entry(title: 'Oceanside', value: 'oceanside'),
                    Entry(title: 'Garden Grove', value: 'gardengrove'),
                    Entry(title: 'Lancaster', value: 'lancaster'),
                    Entry(title: 'Palmdale', value: 'palmdale'),
                    Entry(title: 'Corona', value: 'corona'),
                    Entry(title: 'Salinas', value: 'salinas'),
                    Entry(title: 'Roseville', value: 'roseville'),
                    Entry(title: 'Hayward', value: 'hayward'),
                    Entry(title: 'Sunnyvale', value: 'sunnyvale'),
                    Entry(title: 'Escondido', value: 'escondido'),
                    Entry(title: 'Pomona', value: 'pomona'),
                    Entry(title: 'Visalia', value: 'visalia'),
                    Entry(title: 'Fullerton', value: 'fullerton'),
                    Entry(title: 'Torrance', value: 'torrance'),
                    Entry(title: 'Victorville', value: 'victorville'),
                    Entry(title: 'Orange', value: 'orange'),
                    Entry(title: 'Pasadena', value: 'pasadena'),
                    Entry(title: 'Santa Clara', value: 'santaclara'),
                    Entry(title: 'Clovis', value: 'clovis'),
                    Entry(title: 'Simi Valley', value: 'simivalley'),
                    Entry(title: 'Thousand Oaks', value: 'thousandoaks'),
                    Entry(title: 'Vallejo', value: 'vallejo'),
                    Entry(title: 'Concord', value: 'concord'),
                    Entry(title: 'Fairfield', value: 'fairfield'),
                    Entry(title: 'Berkeley', value: 'berkeley'),
                    Entry(title: 'Antioch', value: 'antioch'),
                    Entry(title: 'Richmond', value: 'richmond'),
                    Entry(title: 'Carlsbad', value: 'carlsbad'),
                    Entry(title: 'Menifee', value: 'menifee'),
                    Entry(title: 'Murrieta', value: 'murrieta'),
                    Entry(title: 'Temecula', value: 'temecula'),
                    Entry(title: 'Santa Maria', value: 'santamaria'),
                    Entry(title: 'Ventura', value: 'ventura'),
                    Entry(title: 'Downey', value: 'downey'),
                    Entry(title: 'Costa Mesa', value: 'costamesa'),
                    Entry(title: 'Jurupa Valley', value: 'jurupavalley'),
                    Entry(title: 'West Covina', value: 'westcovina'),
                    Entry(title: 'El Monte', value: 'elmonte'),
                    Entry(title: 'Rialto', value: 'rialto'),
                    Entry(title: 'El Cajon', value: 'elcajon'),
                    Entry(title: 'Inglewood', value: 'inglewood'),
                    Entry(title: 'Burbank', value: 'burbank'),
                    Entry(title: 'Vacaville', value: 'vacaville'),
                    Entry(title: 'San Mateo', value: 'sanmateo'),
                    Entry(title: 'Chico', value: 'chico'),
                    Entry(title: 'Hesperia', value: 'hesperia'),
                  ],
                ),
                Section(
                  title: 'Colorado',
                  entries: [
                    Entry(title: 'Denver', value: 'denver'),
                    Entry(title: 'Colorado Springs', value: 'coloradosprings'),
                    Entry(title: 'Aurora', value: 'aurora'),
                    Entry(title: 'Fort Collins', value: 'fortcollins'),
                    Entry(title: 'Lakewood', value: 'lakewood'),
                    Entry(title: 'Thornton', value: 'thornton'),
                    Entry(title: 'Arvada', value: 'arvada'),
                    Entry(title: 'Westminster', value: 'westminster'),
                    Entry(title: 'Greeley', value: 'greeley'),
                    Entry(title: 'Pueblo', value: 'pueblo'),
                    Entry(title: 'Centennial', value: 'centennial'),
                    Entry(title: 'Boulder', value: 'boulder'),
                  ],
                ),
                Section(
                  title: 'Connecticut',
                  entries: [
                    Entry(title: 'Bridgeport', value: 'bridgeport'),
                    Entry(title: 'Stamford', value: 'stamford'),
                    Entry(title: 'New Haven', value: 'newhaven'),
                    Entry(title: 'Hartford', value: 'hartford'),
                    Entry(title: 'Waterbury', value: 'waterbury'),
                  ],
                ),
                Section(
                  title: 'Delaware',
                  entries: [
                    Entry(title: 'Wilmington', value: 'wilmington'),
                  ],
                ),
                Section(
                  title: 'Florida',
                  entries: [
                    Entry(title: 'Jacksonville', value: 'jacksonville'),
                    Entry(title: 'Miami', value: 'miami'),
                    Entry(title: 'Tampa', value: 'tampa'),
                    Entry(title: 'Orlando', value: 'orlando'),
                    Entry(title: 'St. Petersburg', value: 'stpetersburg'),
                    Entry(title: 'Port St. Lucie', value: 'portstlucie'),
                    Entry(title: 'Cape Coral', value: 'capecoral'),
                    Entry(title: 'Hialeah', value: 'hialeah'),
                    Entry(title: 'Tallahassee', value: 'tallahassee'),
                    Entry(title: 'Fort Lauderdale', value: 'fortlauderdale'),
                    Entry(title: 'Pembroke Pines', value: 'pembrokepines'),
                    Entry(title: 'Hollywood', value: 'hollywood'),
                    Entry(title: 'Gainesville', value: 'gainesville'),
                    Entry(title: 'Miramar', value: 'miramar'),
                    Entry(title: 'Palm Bay', value: 'palmbay'),
                    Entry(title: 'Coral Springs', value: 'coralsprings'),
                    Entry(title: 'West Palm Beach', value: 'westpalmbeach'),
                    Entry(title: 'Lakeland', value: 'lakeland'),
                    Entry(title: 'Clearwater', value: 'clearwater'),
                    Entry(title: 'Pompano Beach', value: 'pompanobeach'),
                    Entry(title: 'Miami Gardens', value: 'miamigardens'),
                    Entry(title: 'Davie', value: 'davie'),
                    Entry(title: 'Palm Coast', value: 'palmcoast'),
                  ],
                ),
                Section(
                  title: 'Georgia',
                  entries: [
                    Entry(title: 'Atlanta', value: 'atlanta'),
                    Entry(title: 'Columbus', value: 'columbus'),
                    Entry(title: 'Augusta', value: 'augusta'),
                    Entry(title: 'Macon', value: 'macon'),
                    Entry(title: 'Savannah', value: 'savannah'),
                    Entry(title: 'Athens', value: 'athens'),
                    Entry(title: 'South Fulton', value: 'southfulton'),
                    Entry(title: 'Sandy Springs', value: 'sandysprings'),
                  ],
                ),
                Section(
                  title: 'Hawaii',
                  entries: [Entry(title: 'Honolulu', value: 'honolulu')],
                ),
                Section(
                  title: 'Idaho',
                  entries: [
                    Entry(title: 'Boise', value: 'boise'),
                    Entry(title: 'Meridian', value: 'meridian'),
                    Entry(title: 'Nampa', value: 'nampa')
                  ],
                ),
                Section(
                  title: 'Illinois',
                  entries: [
                    Entry(title: 'Chicago', value: 'chicago'),
                    Entry(title: 'Aurora', value: 'aurora'),
                    Entry(title: 'Joliet', value: 'joliet'),
                    Entry(title: 'Naperville', value: 'naperville'),
                    Entry(title: 'Rockford', value: 'rockford'),
                    Entry(title: 'Elgin', value: 'elgin'),
                    Entry(title: 'Springfield', value: 'springfield'),
                    Entry(title: 'Peoria', value: 'peoria')
                  ],
                ),
                Section(
                  title: 'Indiana',
                  entries: [
                    Entry(title: 'Indianapolis', value: 'indianapolis'),
                    Entry(title: 'Fort Wayne', value: 'fortwayne'),
                    Entry(title: 'Evansville', value: 'evansville'),
                    Entry(title: 'Fishers', value: 'fishers'),
                    Entry(title: 'South Bend', value: 'southbend'),
                    Entry(title: 'Carmel', value: 'carmel'),
                  ],
                ),
                Section(
                  title: 'Iowa',
                  entries: [
                    Entry(title: 'Des Moines', value: 'desmoines'),
                    Entry(title: 'Cedar Rapids', value: 'cedarrapids'),
                    Entry(title: 'Davenport', value: 'davenport'),
                  ],
                ),
                Section(
                  title: 'Kansas',
                  entries: [
                    Entry(title: 'Wichita', value: 'wichita'),
                    Entry(title: 'Overland Park', value: 'overlandpark'),
                    Entry(title: 'Kansas City', value: 'kansascity'),
                    Entry(title: 'Olathe', value: 'olathe'),
                  ],
                ),
                Section(
                  title: 'Kentucky',
                  entries: [
                    Entry(title: 'Louisville', value: 'louisville'),
                    Entry(title: 'Lexington', value: 'lexington'),
                  ],
                ),
                Section(
                  title: 'Louisiana',
                  entries: [
                    Entry(title: 'New Orleans', value: 'neworleans'),
                    Entry(title: 'Baton Rouge', value: 'batonrouge'),
                    Entry(title: 'Shreveport', value: 'shreveport'),
                    Entry(title: 'Lafayette', value: 'lafayette'),
                  ],
                ),
                Section(
                  title: 'Maine',
                  entries: [Entry(title: 'Portland', value: 'portland')],
                ),
                Section(
                  title: 'Maryland',
                  entries: [
                    Entry(title: 'Baltimore', value: 'baltimore'),
                  ],
                ),
                Section(
                  title: 'Massachusetts',
                  entries: [
                    Entry(title: 'Boston', value: 'boston'),
                    Entry(title: 'Worcester', value: 'worcester'),
                    Entry(title: 'Springfield', value: 'springfieldma'),
                    Entry(title: 'Cambridge', value: 'cambridge'),
                    Entry(title: 'Lowell', value: 'lowell'),
                    Entry(title: 'Brockton', value: 'brockton'),
                    Entry(title: 'Quincy', value: 'quincy'),
                    Entry(title: 'Lynn', value: 'lynn'),
                    Entry(title: 'New Bedford', value: 'newbedford'),
                  ],
                ),
                Section(
                  title: 'Michigan',
                  entries: [
                    Entry(title: 'Detroit', value: 'detroit'),
                    Entry(title: 'Grand Rapids', value: 'grandrapids'),
                    Entry(title: 'Warren', value: 'warren'),
                    Entry(title: 'Sterling Heights', value: 'sterlingheights'),
                    Entry(title: 'Ann Arbor', value: 'annarbor'),
                    Entry(title: 'Lansing', value: 'lansing'),
                    Entry(title: 'Dearborn', value: 'dearborn'),
                  ],
                ),
                Section(
                  title: 'Minnesota',
                  entries: [
                    Entry(title: 'Minneapolis', value: 'minneapolis'),
                    Entry(title: 'St. Paul', value: 'stpaul'),
                    Entry(title: 'Rochester', value: 'rochester'),
                  ],
                ),
                Section(
                  title: 'Mississippi',
                  entries: [Entry(title: 'Jackson', value: 'jackson')],
                ),
                Section(
                  title: 'Missouri',
                  entries: [
                    Entry(title: 'Kansas City', value: 'kansascity'),
                    Entry(title: 'St. Louis', value: 'stlouis'),
                    Entry(title: 'Springfield', value: 'springfieldmo'),
                    Entry(title: 'Columbia', value: 'columbia'),
                    Entry(title: 'Independence', value: 'independence'),
                    Entry(title: "Lee's Summit", value: 'leessummit'),
                  ],
                ),
                Section(
                  title: 'Montana',
                  entries: [Entry(title: 'Billings', value: 'billings')],
                ),
                Section(
                  title: 'Nebraska',
                  entries: [
                    Entry(title: 'Omaha', value: 'omaha'),
                    Entry(title: 'Lincoln', value: 'lincoln'),
                  ],
                ),
                Section(
                  title: 'Nevada',
                  entries: [
                    Entry(title: 'Las Vegas', value: 'lasvegas'),
                    Entry(title: 'Henderson', value: 'henderson'),
                    Entry(title: 'North Las Vegas', value: 'northlasvegas'),
                    Entry(title: 'Reno', value: 'reno'),
                    Entry(title: 'Sparks', value: 'sparks'),
                  ],
                ),
                Section(
                  title: 'New Hampshire',
                  entries: [
                    Entry(title: 'Manchester', value: 'manchester'),
                  ],
                ),
                Section(
                  title: 'New Jersey',
                  entries: [
                    Entry(title: 'Newark', value: 'newark'),
                    Entry(title: 'Jersey City', value: 'jerseycity'),
                    Entry(title: 'Paterson', value: 'paterson'),
                    Entry(title: 'Lakewood', value: 'lakewood'),
                    Entry(title: 'Elizabeth', value: 'elizabeth'),
                    Entry(title: 'Edison', value: 'edison'),
                    Entry(title: 'Woodbridge', value: 'woodbridge'),
                  ],
                ),
                Section(
                  title: 'New Mexico',
                  entries: [
                    Entry(title: 'Albuquerque', value: 'albuquerque'),
                    Entry(title: 'Las Cruces', value: 'lascruces'),
                    Entry(title: 'Rio Rancho', value: 'riorancho'),
                  ],
                ),
                Section(
                  title: 'New York',
                  entries: [
                    Entry(title: 'New York', value: 'newyork'),
                    Entry(title: 'Buffalo', value: 'buffalo'),
                    Entry(title: 'Yonkers', value: 'yonkers'),
                    Entry(title: 'Rochester', value: 'rochester'),
                    Entry(title: 'Syracuse', value: 'syracuse'),
                    Entry(title: 'Albany', value: 'albany'),
                  ],
                ),
                Section(
                  title: 'North Carolina',
                  entries: [
                    Entry(title: 'Charlotte', value: 'charlotte'),
                    Entry(title: 'Raleigh', value: 'raleigh'),
                    Entry(title: 'Greensboro', value: 'greensboro'),
                    Entry(title: 'Durham', value: 'durham'),
                    Entry(title: 'Winston-Salem', value: 'winstonsalem'),
                    Entry(title: 'Fayetteville', value: 'fayetteville'),
                    Entry(title: 'Cary', value: 'cary'),
                    Entry(title: 'Wilmington', value: 'wilmington'),
                    Entry(title: 'High Point', value: 'highpoint'),
                    Entry(title: 'Concord', value: 'concordnc'),
                  ],
                ),
                Section(
                  title: 'North Dakota',
                  entries: [Entry(title: 'Fargo', value: 'fargo')],
                ),
                Section(
                  title: 'Ohio',
                  entries: [
                    Entry(title: 'Columbus', value: 'columbus'),
                    Entry(title: 'Cleveland', value: 'cleveland'),
                    Entry(title: 'Cincinnati', value: 'cincinnati'),
                    Entry(title: 'Toledo', value: 'toledo'),
                    Entry(title: 'Akron', value: 'akron'),
                    Entry(title: 'Dayton', value: 'dayton'),
                  ],
                ),
                Section(
                  title: 'Oklahoma',
                  entries: [
                    Entry(title: 'Oklahoma City', value: 'oklahomacity'),
                    Entry(title: 'Tulsa', value: 'tulsa'),
                    Entry(title: 'Norman', value: 'norman'),
                    Entry(title: 'Broken Arrow', value: 'brokenarrow'),
                  ],
                ),
                Section(
                  title: 'Oregon',
                  entries: [
                    Entry(title: 'Portland', value: 'portland'),
                    Entry(title: 'Eugene', value: 'eugene'),
                    Entry(title: 'Salem', value: 'salem'),
                    Entry(title: 'Gresham', value: 'gresham'),
                    Entry(title: 'Hillsboro', value: 'hillsboro'),
                    Entry(title: 'Bend', value: 'bend'),
                  ],
                ),
                Section(
                  title: 'Pennsylvania',
                  entries: [
                    Entry(title: 'Philadelphia', value: 'philadelphia'),
                    Entry(title: 'Pittsburgh', value: 'pittsburgh'),
                    Entry(title: 'Allentown', value: 'allentown'),
                  ],
                ),
                Section(
                  title: 'Rhode Island',
                  entries: [
                    Entry(title: 'Providence', value: 'providence'),
                  ],
                ),
                Section(
                  title: 'South Carolina',
                  entries: [
                    Entry(title: 'Charleston', value: 'charleston'),
                    Entry(title: 'Columbia', value: 'columbiasc'),
                    Entry(title: 'North Charleston', value: 'northcharleston'),
                  ],
                ),
                Section(
                  title: 'South Dakota',
                  entries: [
                    Entry(title: 'Sioux Falls', value: 'siouxfalls'),
                  ],
                ),
                Section(
                  title: 'Tennessee',
                  entries: [
                    Entry(title: 'Nashville', value: 'nashville'),
                    Entry(title: 'Memphis', value: 'memphis'),
                    Entry(title: 'Knoxville', value: 'knoxville'),
                    Entry(title: 'Chattanooga', value: 'chattanooga'),
                    Entry(title: 'Clarksville', value: 'clarksville'),
                    Entry(title: 'Murfreesboro', value: 'murfreesboro'),
                  ],
                ),
                Section(
                  title: 'Texas',
                  entries: [
                    Entry(title: 'Houston', value: 'houston'),
                    Entry(title: 'San Antonio', value: 'sanantonio'),
                    Entry(title: 'Dallas', value: 'dallas'),
                    Entry(title: 'Austin', value: 'austin'),
                    Entry(title: 'Fort Worth', value: 'fortworth'),
                    Entry(title: 'El Paso', value: 'elpaso'),
                    Entry(title: 'Arlington', value: 'arlington'),
                    Entry(title: 'Corpus Christi', value: 'corpuschristi'),
                    Entry(title: 'Plano', value: 'plano'),
                    Entry(title: 'Lubbock', value: 'lubbock'),
                    Entry(title: 'Laredo', value: 'laredo'),
                    Entry(title: 'Irving', value: 'irving'),
                    Entry(title: 'Garland', value: 'garland'),
                    Entry(title: 'Frisco', value: 'frisco'),
                    Entry(title: 'McKinney', value: 'mckinney'),
                    Entry(title: 'Amarillo', value: 'amarillo'),
                    Entry(title: 'Grand Prairie', value: 'grandprairie'),
                    Entry(title: 'Brownsville', value: 'brownsville'),
                    Entry(title: 'Killeen', value: 'killeen'),
                    Entry(title: 'Denton', value: 'denton'),
                    Entry(title: 'Mesquite', value: 'mesquite'),
                    Entry(title: 'Pasadena', value: 'pasadenatx'),
                    Entry(title: 'McAllen', value: 'mcallen'),
                    Entry(title: 'Waco', value: 'waco'),
                    Entry(title: 'Midland', value: 'midland'),
                    Entry(title: 'Lewisville', value: 'lewisville'),
                    Entry(title: 'Carrollton', value: 'carrollton'),
                    Entry(title: 'Round Rock', value: 'roundrock'),
                    Entry(title: 'Abilene', value: 'abilene'),
                    Entry(title: 'Pearland', value: 'pearland'),
                    Entry(title: 'College Station', value: 'collegestation'),
                    Entry(title: 'Richardson', value: 'richardson'),
                    Entry(title: 'League City', value: 'leaguecity'),
                    Entry(title: 'Odessa', value: 'odessa'),
                    Entry(title: 'Beaumont', value: 'beaumont'),
                    Entry(title: 'Allen', value: 'allen'),
                    Entry(title: 'New Braunfels', value: 'newbraunfels'),
                    Entry(title: 'Tyler', value: 'tyler'),
                    Entry(title: 'Sugar Land', value: 'sugarland'),
                    Entry(title: 'Conroe', value: 'conroe'),
                    Entry(title: 'Edinburg', value: 'edinburg'),
                    Entry(title: 'Wichita Falls', value: 'wichitafalls'),
                  ],
                ),
                Section(
                  title: 'Utah',
                  entries: [
                    Entry(title: 'Salt Lake City', value: 'saltlakecity'),
                    Entry(title: 'West Valley City', value: 'westvalleycity'),
                    Entry(title: 'West Jordan', value: 'westjordan'),
                    Entry(title: 'Provo', value: 'provo'),
                    Entry(title: 'St. George', value: 'stgeorge'),
                  ],
                ),
                Section(
                  title: 'Vermont',
                  entries: [
                    Entry(title: 'Burlington', value: 'burlington'),
                  ],
                ),
                Section(
                  title: 'Virginia',
                  entries: [
                    Entry(
                      title: 'Virginia Beach',
                      value: 'virginiabeach',
                    ),
                    Entry(title: 'Chesapeake', value: 'chesapeake'),
                    Entry(title: 'Norfolk', value: 'norfolk'),
                    Entry(title: 'Richmond', value: 'richmond'),
                    Entry(title: 'Newport News', value: 'newportnews'),
                    Entry(title: 'Alexandria', value: 'alexandria'),
                    Entry(title: 'Hampton', value: 'hampton'),
                    Entry(title: 'Suffolk', value: 'suffolk'),
                  ],
                ),
                Section(
                  title: 'Washington',
                  entries: [
                    Entry(title: 'Seattle', value: 'seattle'),
                    Entry(title: 'Spokane', value: 'spokane'),
                    Entry(title: 'Tacoma', value: 'tacoma'),
                    Entry(title: 'Vancouver', value: 'vancouverwa'),
                    Entry(title: 'Bellevue', value: 'bellevue'),
                    Entry(title: 'Kent', value: 'kent'),
                    Entry(title: 'Everett', value: 'everett'),
                    Entry(title: 'Spokane Valley', value: 'spokanevalley'),
                    Entry(title: 'Renton', value: 'renton'),
                  ],
                ),
                Section(
                  title: 'West Virginia',
                  entries: [
                    Entry(title: 'Charleston', value: 'charleston'),
                  ],
                ),
                Section(
                  title: 'Wisconsin',
                  entries: [
                    Entry(title: 'Milwaukee', value: 'milwaukee'),
                    Entry(title: 'Madison', value: 'madison'),
                    Entry(title: 'Green Bay', value: 'greenbay'),
                  ],
                ),
                Section(
                  title: 'Wyoming',
                  entries: [Entry(title: 'Cheyenne', value: 'cheyenne')],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NumbersExpandableBoxDrawingTable extends StatelessWidget {
  const _NumbersExpandableBoxDrawingTable(
      {super.key,
      required this.isUsingCustomConfiguration,
      required this.sharedPreferences});
  final bool isUsingCustomConfiguration;
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 24.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: ExpandableBoxDrawingTable<String>(
          configuration: isUsingCustomConfiguration
              ? const ExpandableBoxDrawingTableConfigurationData(
                  sectionsHaveCheckBoxes: false,
                  entriesHaveCheckBoxes: true,
                  expandedIcon: Icons.catching_pokemon,
                  collapsedIcon: Icons.bubble_chart_outlined,
                )
              : ExpandableBoxDrawingTableConfigurationData
                  .defaultConfiguration(),
          initialValues:
              sharedPreferences.getStringList('enabled_numbers') ?? [],
          onValuesChanged: (values) {
            sharedPreferences.setStringList('enabled_numbers', values);
          },
          sections: [
            Section(
              title: '1',
              subSections: [
                Section(
                  title: '1.1',
                  entries: [
                    Entry(
                      title: '1.1.1',
                      value: '1.1.1',
                    ),
                    Entry(
                      title: '1.1.2',
                      value: '1.1.2',
                    ),
                  ],
                ),
                Section(
                  title: '1.2',
                  subSections: [
                    Section(
                      title: '1.2.1',
                      entries: [
                        Entry(title: '1.2.1.1', value: '1.2.1.1'),
                        Entry(title: '1.2.1.2', value: '1.2.1.2'),
                      ],
                    ),
                    Section(
                      title: '1.2.2',
                      entries: [
                        Entry(title: '1.2.2.1', value: '1.2.2.1'),
                        Entry(title: '1.2.2.2', value: '1.2.2.2'),
                      ],
                    ),
                  ],
                ),
                Section(
                  title: '1.3',
                  subSections: [
                    Section(
                      title: '1.3.1',
                      entries: [
                        Entry(title: '1.3.1.1', value: '1.3.1.1'),
                        Entry(title: '1.3.1.2', value: '1.3.1.2'),
                      ],
                    ),
                    Section(
                      title: '1.3.2',
                      entries: [
                        Entry(title: '1.3.2.1', value: '1.3.2.1'),
                        Entry(title: '1.3.2.2', value: '1.3.2.2'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Section(
              title: '2',
              subSections: [
                Section(
                  title: '2.1',
                  entries: [
                    Entry(
                      title: '2.1.1',
                      value: '2.1.1',
                    ),
                    Entry(
                      title: '2.1.2',
                      value: '2.1.2',
                    ),
                  ],
                ),
                Section(
                  title: '2.2',
                  subSections: [
                    Section(
                      title: '2.2.1',
                      entries: [
                        Entry(title: '2.2.1.1', value: '2.2.1.1'),
                        Entry(title: '2.2.1.2', value: '2.2.1.2'),
                      ],
                    ),
                    Section(
                      title: '2.2.2',
                      entries: [
                        Entry(title: '2.2.2.1', value: '2.2.2.1'),
                        Entry(title: '2.2.2.2', value: '2.2.2.2'),
                      ],
                    ),
                  ],
                ),
                Section(
                  title: '2.3',
                  subSections: [
                    Section(
                      title: '2.3.1',
                      entries: [
                        Entry(title: '2.3.1.1', value: '2.3.1.1'),
                        Entry(title: '2.3.1.2', value: '2.3.1.2'),
                      ],
                    ),
                    Section(
                      title: '2.3.2',
                      entries: [
                        Entry(title: '2.3.2.1', value: '2.3.2.1'),
                        Entry(title: '2.3.2.2', value: '2.3.2.2'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
