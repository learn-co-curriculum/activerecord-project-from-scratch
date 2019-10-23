# Setting up your own ActiveRecord project from scratch

We've covered lots of ActiveRecord concepts - setup, models, migrations, finding records - but so far, the labs have provided the necessary configuration to get the basics working. 

This README covers how to set up your own ActiveRecord project, so that you can experiment on your own.

If you instead want to copy the finished configuration from this (or another working lab), that's okay too. Our goal in this section is to learn about using ActiveRecord to model data, not to learn about installation and configuration.

* Gemfile
* Configuration
* Rakefile
* Migrations and Schema
* Models

This walkthrough assumes that you are starting from scratch in an otherwise empty folder.

## Gemfile

1. `bundle init` to create a new Gemfile
2. add the gems by editing the Gemfile 

```ruby
gem "rake"
gem "sqlite3"
gem "activerecord", require: "active_record"
gem "sinatra-activerecord"
gem "pry"
gem "require_all"
```

3. run `bundle install` (or just `bundle`) to get the gems

**Note**: `sinatra-activerecord` just provides the Rake tasks for running migrations. We aren't using Sinatra here.

## Configuration

1. Create a folder `config` to store your configuration
2. Create a file `config/environment.rb` for your environment setup
3. Add the environment setup to the environment file:

```ruby
require 'bundler/setup'
Bundler.require

ActiveRecord::Base.configurations = {
  development: {
    adapter: 'sqlite3',
    database: 'db/database-name.db'
  }
}
ActiveRecord::Base.establish_connection(:development)

require_all 'app'
```

You can change what your database will be called, if you need to.

## Rakefile

1. Create a file called `Rakefile`
2. Add the following setup to the Rakefile to load the ActiveRecord Rake tasks and add a console task:

```ruby
require_relative 'config/environment.rb'
require "sinatra/activerecord/rake"

desc "Start our app console"
task :console do
  Pry.start
end
```

After this step, running `rake -T` should print a list of available tasks, which should include the standard set of database creation and migration tasks.

## Migrations and Schema

These steps are completed with a sample domain model. Use yours instead of this one.

1. Create your first migration with `rake db:create_migration NAME=add_students` (yours doesn't need to be called `add_students`)
2. Define the `change` method in the new migration file. Your first one is probably creating a table.

`db/migrate/20191023180100_add_students.rb`

```
class AddStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.name :text
      t.age :integer
    end
  end
end
```

3. Run the migration to create the table with `rake db:migrate`

## Models

1. Create model files in `app/models` to correspond to the database tables you create. For this app, `app/models/student.rb`

```ruby
class Student < ActiveRecord::Base
end
```
