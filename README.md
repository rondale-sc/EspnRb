# EspnRb

A ruby wrapper for the ESPN api.  It allows you to interact, in a semantically pleasing way, with the ESPN api.  Currently it only allows access to the publicly available Headline API which can be found [here](http://developer.espn.com/docs/headlines).  I am working to bring more of ESPN's features to espn_rb.  While I do that I'll try to keep this document updated to its current functionality.  That said, I hope you enjoy. 

## Installation

Add this line to your application's Gemfile:
    
    gem 'espn_rb'

## Espn Headines

Instantiate the EspnRb object and check the headlines.

#### Get all headlines

```ruby
require 'espn_rb'
espn = Espn.rb

espn.all
```

Which will return an HeadlineResponse object.  To get the response straight from the horses' mouth:

#### Get ESPN response as JSON

```ruby
# from above
  
espn.all.response
#=> ESPN's response string as JSON
```

The raw response from ESPN will give you the top ten stories meeting your criteria.  Since this is a basic collection and each headline share many common attributes there are collection methods defined on the HeadlineResponse object.  Use them like so.

#### Collections

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
espn = EspnRb.new
espn.basketball(:news) #=> HeadlineResponse
espn.basketball(:top)  #=> HeadlineResponse
```


I am actively work on this. Check the commit log to see where I'm at, and check the issues to see how you can contribute.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
