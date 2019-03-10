# Riddler

Riddler is a dynamic content and workflow engine.

## Usage

### Basic Example (using Liquid)

Riddler combines a ContentDefinition with a Context to render the output (using
Liquid - https://shopify.github.io/liquid/)

```ruby
require "riddler"

content_definition = {
  "id"=>"el_text",
  "name"=>"text",
  "content_type"=>"element",
  "type"=>"text",
  "text"=>"Hello {{ params.name }}!"
}

Riddler.render content_definition

# {:content_type=>"element", :type=>"text", :id=>"el_text", :name=>"text", :text=>"Hello !"}

Riddler.render content_definition, params: {name: "World"}

# {:content_type=>"element", :type=>"text", :id=>"el_text", :name=>"text", :text=>"Hello World!"}
```

### Predicate Example (using Predicator)

Pieces of content can define if they should be included or not. Here we use the
`include_predicate` to specify that it should only be included if `params.name = 'foo'`.

```ruby
require "riddler"

content_definition = {
  "id"=>"el_text",
  "name"=>"text",
  "content_type"=>"element",
  "type"=>"text",
  "text"=>"Hello {{ params.name }}!",
  "include_predicate" => "params.name = 'foo'"
}

Riddler.render content_definition

# nil

Riddler.render content_definition, params: {name: "foo"}

# {:content_type=>"element", :type=>"text", :id=>"el_text", :name=>"text", :text=>"Hello foo!"}
```


### PokeAPI ContextBuilder example

One way Riddler can be extended is by adding new ContextBuilders. Let's add the ability to look up a Pokemon at https://pokeapi.co/

We will then pass in a `pokemon_id` as a param

This also shows Liquid filters - capitalizing the name

```ruby
require "riddler"
require "net/http"

class PokemonContextBuilder < ::Riddler::ContextBuilder
  # Does the current context have the data available for this builder to function
  def data_available?
    context.params.pokemon_id
  end

  # Extract IDs from the context (params, headers, JWTs, etc) and store
  # them in context.ids
  def extract_ids
    add_id :pokemon_id, context.params.pokemon_id
  end

  def process
    uri = URI "https://pokeapi.co/api/v2/pokemon/#{pokemon_id}/"
    response_string = Net::HTTP.get uri
    response = JSON.parse response_string

    context.assign "pokemon", response
  end
end

Riddler.configure { |c| c.context_builders << PokemonContextBuilder }

content_definition = {
  "id"=>"el_text",
  "name"=>"text",
  "content_type"=>"element",
  "type"=>"text",
  "text"=>"Hello {{ pokemon.name | capitalize }}!"
}

Riddler.render content_definition, params: {pokemon_id: "1"}

# {:content_type=>"element", :type=>"text", :id=>"el_text", :name=>"text", :text=>"Hello Bulbasaur!"}
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
