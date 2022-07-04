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

Require before you require any of your tests in the `spec_helper.cr`.

```crystal
require "spectator"
require "../src/your_grip_app"
```

Create a test file for each of the controllers located in your project file.

```crystal
# The source code for the UsersController
module MoneyStore
  module Controllers
    class UsersController < Grip::Controllers::Http
      def get(context : Context)
        context
          .put_status(201)
          .json({"message" => "Hello, World!"})
      end
    end
  end
end
```

```crystal
# The source code for the Application
module MoneyStore
  class Application < Grip::Application
    def routes
      scope "/api" do
        scope "/users" do
          get "/", Controllers::UsersController
        end
      end
    end
  end
end
```

```crystal
# The source code for the UsersControllerTest
module MoneyStore
  module Controllers
    module UsersControllerTest
      include Spectator::Macros

      describe UserController do
        it "renders /" do
          response = get Application.new, "/api/users/"
          response.status_code.should eq 201
        end
      end
    end
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
