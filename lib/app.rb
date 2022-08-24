
require_relative './database_connection'
require_relative './artist_repository.rb'
require_relative './album_repository.rb'

class Application

    # The Application class initializer
    # takes four arguments:
    #  * The database name to call `DatabaseConnection.connect`
    #  * the Kernel object as `io` (so we can mock the IO in our tests)
    #  * the AlbumRepository object (or a double of it)
    #  * the ArtistRepository object (or a double of it)
    def initialize(database_name, io, album_repository, artist_repository)
      DatabaseConnection.connect(database_name)
      @io = io
      @album_repository = album_repository
      @artist_repository = artist_repository
    end
  
    def run
        @io.puts print_intro
        make_choice
    end

    private

    def print_intro
        return "Welcome to the music library manager!\nWhat would you like to do?\n1 - List all albums\n2 - List all artists"
    end

    def make_choice
      @io.puts "Enter your choice:"
      choice = @io.gets.chomp
      logic(choice)
    end

    def logic(choice)
      if choice == '1'
        print_albums
      elsif choice == '2'
        print_artists
      else 
        @io.puts "Please only enter '1' or '2'"
        make_choice
      end
    end

    def print_albums
      album_formatted_list = @album_repository.all.map do |record|
        "#{record.id} - #{record.title}"
      end
      @io.puts album_formatted_list.join("\n")
    end

    def print_artists
      artist_formatted_list = @artist_repository.all.map do |record|
        "#{record.id} - #{record.name}"
      end
      @io.puts artist_formatted_list.join("\n")
    end

end
  



  # Don't worry too much about this if statement. It is basically saying "only
  # run the following code if this is the main file being run, instead of having
  # been required or loaded by another file.
  # If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
)
app.run
end