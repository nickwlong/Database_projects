
require_relative 'lib/database_connection'
require_relative 'lib/artist_repository.rb'
require_relative 'lib/album_repository.rb'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

artist_repository = AlbumRepository.new


p artist_repository.find(3)