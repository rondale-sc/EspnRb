# EspnRb

This is a ruby wrapper for the ESPN api.

## Installation

Add this line to your application's Gemfile:

    gem 'espn_rb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install espn_rb

## Usage

This is my most recent project and is very much in its infancy.

#### Get all headlines

```ruby
  require 'espn_rb'
  espn = Espn.rb

  espn.all_headlines
```

I am actively work on this. Check the commit log to see where I'm at, and check the issues to see how you can contribute.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
