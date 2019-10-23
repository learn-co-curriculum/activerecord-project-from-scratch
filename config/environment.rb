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
