# Riddler

Riddler is a dynamic content and workflow engine.


## Example

```ruby
require "riddler"

step_definition = {
  "id"=>"st_1F0jZG9Wtzx",
  "object"=>"content",
  "elements"=>[
    {"id"=>"el_1F0jZjWQenOW", "text"=>"Hello {{ params.name }}", "object"=>"copy"}
  ]
}

preview = Riddler::UseCases::PreviewStep.new step_definition, params: { name: "World" }

content = preview.process

# {:type=>"content",
# :id=>"st_1F0jZG9Wtzx",
# "elements"=>[{:type=>"copy", :id=>"el_1F0jZjWQenOW", :text=>"Hello World!"}]}
```

### PokeAPI ContextBuilder example

One way Riddler can be extended is by adding new `ContextBuilder`s.
Let's add the ability to look up a Pokemon at https://pokeapi.co/

We will then pass in a `pokemon_id` as a param

```ruby
require "riddler"
require "net/http"

class PokemonContextBuilder < ::Riddler::ContextBuilder
  def process
    return unless context.params.pokemon_id

    pokemon_id = context.params.pokemon_id
    uri = URI "https://pokeapi.co/api/v2/pokemon/#{pokemon_id}/"
    response_string = Net::HTTP.get uri
    response = JSON.parse response_string

    context.assign "pokemon", response
  end
end

Riddler.configure { |c| c.context_builders << PokemonContextBuilder }

step_definition = {
  "id"=>"st_1F0jZG9Wtzx",
  "object"=>"content",
  "elements"=>[
    {"id"=>"el_1F0jZjWQenOW", "text"=>"Pokemon name {{ pokemon.name }}", "object"=>"copy"}
  ]
}

preview = Riddler::UseCases::PreviewStep.new step_definition, params: { pokemon_id: "1" }

content = preview.process

# {:type=>"content",
# :id=>"st_1F0jZG9Wtzx",
# "elements"=>[{:type=>"copy", :id=>"el_1F0jZjWQenOW", :text=>"Pokemon name bulbasaur"}]}

```

## Installation

Add this line to your application's Gemfile:

```ruby
gem "riddler"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install riddler


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/riddler/riddler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Riddler project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/riddler/riddler/blob/master/CODE_OF_CONDUCT.md).
