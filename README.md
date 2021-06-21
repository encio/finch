# finch
This is for tracking the bus and train routes for finch station

Table of Contents:
- The API
- How did I interpret the json?
- What architecture did I use and why did I choose this architecture?
- Project Structure
- Future improvents



## The API
This is the endpoint used in this project:
https://myttc.ca/finch_station.json

The json is quite confusing because along with the BUS bays and TRAIN platforms, other places in the Finch staion such as mezzanine and elevators are included in the json.


## How did I interpret the json?

Sample response:

"name": "Finch Station Bus Bay",
"uri": "finch_station_bus_bay",
	"routes": [
		{
		"route_group_id": "32",
		"name": "36 Finch West",
		"uri": "36_finch_west",
		"stop_times": [
			{
			"departure_time": "9:56p",
			"departure_timestamp": 1624240569,
			"service_id": 3,
			"shape": "36B Finch West To Humberwood"
			}
		]
	]
]

stops[]
- This contains the different part of the station. Im only interested in finch_station_bus_bay and finch_station_subway_platform uri

routes[]
- This identifies the platforms or the bays. Buses have multiple bays indicated by 'name' parameter

stopTimes[]
- Each routes(bays and platform) has multiple destinations and with different departure times, it was indicated in this array

Note that some of the bus bays have the same destination but on differs on the letters on the 'shape' of the reponse,
-	"36D Finch West To Weston Road And Milvan" and "36C Finch West To Weston Road And Milvan"

I treated those as sections of the bus bays, (imagine same bus bay with different lines)



## What architecture did I use and why did I choose this architecture?

Even though this is a very simple project and can be accomplished by simple lines of code, I decided to give this a good foundation. It may be over engineering a simple flow but this will appreciated on a longer run.

The architecture I used is closed to DDD(domain driven design) where you have multiple layers to separate concerns in the project. I've been playing with flutter alot and I realized that since flutter app can both run in web and mobile. Having to separate the business logic will allow large chucks of code reuse.

For presentation layer, I used MVP.


## Project Structure
Following the said architecture, I structured the project this way:


Infrastracture
- This is for the part of the code base which is responsible for getting or storing data from and outside resource. Codes such as services(fetching of data via nsurl) is part of this. Also, if we are going to add analytics or push notifications, all of those will be included in infratracture

Domain
- This is where the business logic lives. What to do after fetching data, such as filtering and all shall be done this part. It should be independent of any UI related task and any platform task.
- Because of this separation, if we want to make a supplement apple watch app for this, we can easily reuse the logic. Just create an engine for it.

Presentation
- This is for everything related to displaying it to user using iphone. This is platform specific.
- MVP is the design pattern I "somewhat" followed. I say "somewhat" because I broke some flow to move logic in domain level. Here is good resource for MVP https://saad-eloulladi.medium.com/ios-swift-mvp-architecture-pattern-a2b0c2d310a3

Coordinator
- This is to control the flow of the app. Also I use this for glueing or connecting the Domain -> Presenter -> View

Important thing to note that since Im using a tab bar, each bar has its own coordinator.

Here is a visual diagram how everything is designed: https://drive.google.com/file/d/1wjAD50qGaTKAWJFprFzIMvrneNYZdAnx/view


## Future improvents
Since we already have a nice architecture we can easily add features such as ...  you can finish the sentence






