require_relative './lib/online_library_runner'
require_relative './db_setup'

puts $LOADED_FEATURES.grep(/user/)

puts "testing changes"

user = User.create(name: "Alice", password: "secret123")
puts user.inspect

online_library_runner = OnlineLibraryRunner.new

online_library_runner.run
