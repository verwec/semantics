## Installation

Add this line to your application's Gemfile:

```ruby
gem 'semantics'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install semantics
    
    
Create a .env file containing your API TOKEN

``` TOKEN <YOUR API TOKEN>```

## Getting Started


### Content Projects

Create a new Content Project:

``` Semantics::ContentProject.create(name_of_the_project, engine_configuration) ```

Find a Content Project:

``` Semantics::ContentProject.find(content_project_id) ```

### Objects (Things)

Create an Object:

``` Semantics::Thing.create(content_project_id, uid, name, pure_date) ```

Display all Objects from different Content Projects:

```  Semantics::Thing.all ``` 

Display Objects from a specific Content Project:

```  Semantics::Thing.all(content_project_id) ``` 

Find an Object:

```  Semantics::Thing.find(content_project_id, object_id) ``` 

Update an Object:

``` thing.update(uid, name, pure_date) ``` 

Destroy an Object 

``` thing.destroy ```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/semantics. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

