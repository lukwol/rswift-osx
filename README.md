# RSwift::OSX

RSwift::OSX lets you execute rake commands specific to OSX project.

RSwift::OSX uses rswift and rswift-shared gems.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rswift-osx'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rswift-osx

## Usage

Add this line to `Rakefile` in project directory

```ruby
require 'rswift/osx'
```

By default rswift will find project settings on it's own.
Group names and configurations have default initial values.
If you use custom configuration create `.rswift.yml` to specify different project settings.

```yml
app_scheme_name: MyApp
product_name: MyApp
app_group: MyApp                                    #Default: app
spec_group: MyAppSpec                               #Default: spec
debug_build_configuration: Debug                    #Default: Debug
release_build_configuration: Release                #Default: Release
debug_product_bundle_identifier: co.rswift.myapp
release_product_bundle_identifier: co.rswift.myapp
```

To display all tasks simply run `rake -T`

### Available tasks

```
rake build              # Build workspace
rake clean              # Clean build objects
rake pod:clean          # Clean cocoapods
rake run                # Run the application
rake spec               # Run the test/spec suite
rake update:references  # Update file references
```

Default task is `rake run`

Additionaly task `rake run` can be executed with flag `debug=1`, which enables LLDB.

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lukwol/rswift-osx.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

