# Semantics

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/semantics`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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

## Usage

### Content Projects

Create a new content project

``` Semantics::ContentProject.create(name_of_the_project, engine_configuration) ```

Find a content project

``` Semantics::ContentProject.find(content_project_id) ```

### Objects (Things)

Create a new thing

``` Semantics::Thing.create(content_project_id, uid, name, pure_date) ```

Find a thing

```  Semantics::Thing.find(content_project_id, uid) ``` 

Update a thing

``` Semantics::Thing.update(content_project_id, object_id, uid, name, pure_date) ``` 

Delete a thing 

``` Semantics::Thing.destroy(content_project_id, object_id) ```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/semantics. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

