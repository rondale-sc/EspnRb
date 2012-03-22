# EspnRb

A ruby wrapper for the ESPN api.  It allows you to interact, in a semantically pleasing way, with the ESPN api.  Currently it only allows access to the publicly available Headline API which can be found [here](http://developer.espn.com/docs/headlines).  I am working to bring more of ESPN's features to espn_rb.  While I do that I'll try to keep this document updated to its current functionality.  That said, I hope you enjoy.

![ESPN api logo](http://a.espncdn.com/i/apis/attribution/espn-api-black_200.png "See more branding options at developer.espn.com/branding")  in mind.  ^_^

## Installation

Add this line to your application's Gemfile:

    gem "espn_rb"

In order to use espn_rb you need to first get an API key from ESPN [ESPN api request](http://developer.espn.com/member/register).  Once you've gotten that squared away you can use the public requests straight away.


## Set your API key

The easiest way to set your api key for use with espn_rb is to export it as an environment variable. Do that like so:

```sh
 $ export espn_api_key=YOUR_SUPER_SECRET_API_KEY
```

If you want to pass it in to your objects you may do so explicitly like so:

```ruby
  espn = EspnRb.headlines(:api_key => YOUR_SUPER_SECRET_API_KEY)
```

For the sake of simplicity all my examples will assume that you have exported the API key as an environment variable.

## Espn Headines

Instantiate the EspnRb object and check the headlines.

#### Get all headlines

```ruby
require 'espn_rb'
espn = Espn.headlines

espn.all
#=> HeadlineResponse
```

Which will return an HeadlineResponse object.

#### Get ESPN response as a hash

To get the response straight from the horses' mouth:

```ruby
# from above

espn.all.response
#=> ESPN's response string as a hash
```

The raw response from ESPN will give you the top ten stories meeting your criteria.

### HeadlineResponse

Now includes Enumerable which allows you to treat the HeadlineResponse as an iterable object.

```ruby
espn = EspnRb.headlines
espn.all.map(&:title)

#=> ["Celtics-Clippers Preview",
#    "Warriors 97, Clippers 93",
#    "Hawks 106, Kings 99",
#    "Warriors-Clippers, Box",
#    "Warriors 97, Clippers 93",
#    "Hawks 106, Kings 99",
#    "Bucks-Nets Preview",
#    "Hawks-Kings, Box",
#    "Grizzlies 94, Nuggets 91",
#    "Grizzlies-Nuggets, Box"]

```

#### Collections

Since the above response is a basic collection and each headline share many common attributes there are collection methods defined on the HeadlineResponse object.  Use them like so.

```ruby
# from above

# Available methods are [headlines descriptions sources bylines types]

espn.all.response.titles
#=> ["array", "of", "ESPN", "titles"]

espn.all.response.descriptions
#=> ["array", "of", "ESPN", "descriptions"]

# etc...
```

#### API methods

When calling on the api to get new data you can pass any (soon) of the methods supported by the API.

```ruby
espn = EspnRb.headlines

espn.nba(:news) #=> HeadlineResponse
espn.nba(:top)  #=> HeadlineResponse
espn.nba(:for_date => "2012-03-09")  #=> HeadlineResponse # Will include all stories for that date
espn.nba(:for_athlete => "1234")     #=> HeadlineResponse # Will include all stories for that athleteId

```

### HeadlineItem

The HeadlineResponse Object holdes in it the headlines split into HeadlineItems.  Here is where you can get Specific information about each story.  Some of the options are:

```ruby
espn = EspnRb.headlines
headline_item = espn.nba[2] #=> HeadlineItem

headline_item.web_url #=> "http://sports.espn.go.com/espn/wire?section=nba&id=7664408&ex_cid=espnapi_public"
headline_item.id #=> 7664408
headline_item.title #=> "Mavericks-Kings Preview"
headline_item.athletes #=> ["Johnny B", "Freddie Flintstone", "Etc"]
headline_item.leagues #=> ["46"]
headline_item.athlete_ids #=> ["123", "132", "123"]

# More to come in future versions.
headline_response.headline #=> JSON hash from original response.
```

HeadlineItem will now also respond to #images which will return an HeadlineResponse::HeadlineItem::Images class which contains the images associated with the HeadlineItem in a class that is also enumerable which lets you access the images with nice little methods like:

```ruby
espn = EspnRb.headlines
headline_item = espn.nfl[2]

headline_item.images => HeadlineResponse::HeadlineItem::Images

# or to actually use the images

images = headline_item.images

images.first.landscape #=> true
images.first.url #=> http://path-to-img.com/blah-blah-blah

# or list all the urls

images.map(&:url) #=>  ["list", "of", "image", "urls"]
```
#### HELP

```ruby
espn = Espn.headlines
espn.help
#=> methods/descriptions below....
```
You are currently using the headlines api from here you can do the follow:

    Method                    Description

	:all                      News across all sports/sections
	:golf                     Golf
	:boxing                   Boxing
	:mma                      Mixed Martial Arts
	:racing                   Auto Racing
	:soccer                   Professional soccer (US focus)
	:tennis                   Tennis
	:mlb                      Major League Baseball (MLB)
	:nba                      National Basketball Association (NBA)
	:nfl                      National Football League (NFL)
	:nhl                      National Hockey League (NHL)
	:nascar                   NASCAR racing
	:wnba                     Women's National Basketball Association (WNBA)
	:ncaa_basketball          NCAA Men's College Basketball
	:ncaa_football            NCAA College Football
	:ncaa_womens_basketball   NCAA Women's College Basketball



---
I am actively work on this. Check the commit log to see where I'm at, and check the issues to see how you can contribute.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
