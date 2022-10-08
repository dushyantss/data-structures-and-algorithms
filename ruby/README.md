# Algorithms
This gem will contain useful algorithms and data structures like linked_list, heap, etc.


## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ds-algorithms

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ds-algorithms

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies and compile the c extensions. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### C extensions
If you work on a c extension you need to do the following:
* After any change to any file within `ext` folder, run `rake compile`(included in `bin/setup`).
* To add a new c extension create new folder structure similar to the one for doubly_linked_list, along with `extconf.rb`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dushyantss/algorithms/ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/dushyantss/algorithms/blob/master/ruby/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Algorithms project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dushyantss/algorithms/blob/master/ruby/CODE_OF_CONDUCT.md).
