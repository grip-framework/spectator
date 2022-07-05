# Spectator

A test suite for the Grip framework.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     grip:
       github: grip-framework/grip

     spectator:
       github: grip-framework/spectator
   ```

2. Run `shards install`

## Usage

Require after you require any of your tests in the `spec_helper.cr`.

```crystal
require "../src/your_grip_app"
require "spectator"
```

Test the controllers using the Spectator shard.

```crystal
describe "Controller test example" do
  it "renders /" do
    response = get Application.new, "/"
    response.status_code.should eq 200
  end
end
```

## Contributing

1. Fork it (<https://github.com/grip-framework/spectator/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Giorgi Kavrelishvili](https://github.com/grip-framework) - creator and maintainer
