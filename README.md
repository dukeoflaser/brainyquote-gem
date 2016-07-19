# BrainyQuote
A simple Command Line Interface that allows the user to receive a randomly
selected quote based on topic of the user's choice.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'brainyquote'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brainyquote

## Usage

After installation, simply type `brainyquote` to access the BrainyQuote interface.
Hitting 'enter' will display a list of topics.
Choose a topic via the associated number to receive a quote.
The user can type `y` to get another quote from the same topic as many times
as he or she wishes.
Type `n` to view the list of topics again.
Leave the interface at any time by typing `exit`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/BrainyQuote. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


##TODO
A class that tracks topic lists needs to be created.
Should be able to save scraped data as objects so iteration doesn't happen every time.
The Random URL should be reused until all quotes are exhausted.
Fix Instructions.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
