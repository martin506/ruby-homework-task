require_relative './lib/online_library_runner'
require_relative './db_setup'

MigrationsRunner.new.run

online_library_runner = OnlineLibraryRunner.new

online_library_runner.run
