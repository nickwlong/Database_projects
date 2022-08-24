require 'app'
require 'database_connection'

RSpec.describe Application do

    def reset_albums_table
        seed_sql = File.read('spec/seeds_albums.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end
      
    before(:each) do 
        reset_albums_table
    end


    describe '#run' do
        it 'Should return a formatted list of albums to the terminal' do
            io = double :io

            app = Application.new(
                'music_library_test',
                io,
                AlbumRepository.new,
                ArtistRepository.new
            )
            expect(io).to receive(:puts).with("Welcome to the music library manager!\nWhat would you like to do?\n1 - List all albums\n2 - List all artists")
            expect(io).to receive(:puts).with("Enter your choice:")
            expect(io).to receive(:gets).and_return("1")
            expect(io).to receive(:puts).with("1 - Bossanova\n2 - Surfer Rosa")

            app.run 
        end
        it 'Should return a formatted list of artists to the terminal' do
            io = double :io

            app = Application.new(
                'music_library_test',
                io,
                AlbumRepository.new,
                ArtistRepository.new
            )
            expect(io).to receive(:puts).with("Welcome to the music library manager!\nWhat would you like to do?\n1 - List all albums\n2 - List all artists")
            expect(io).to receive(:puts).with("Enter your choice:")
            expect(io).to receive(:gets).and_return("2")
            expect(io).to receive(:puts).with("1 - Pixies\n2 - Radiohead")

            app.run 
        end
        it 'Should request a re-entry of choice if not 1 or 2' do
            io = double :io

            app = Application.new(
                'music_library_test',
                io,
                AlbumRepository.new,
                ArtistRepository.new
            )
            expect(io).to receive(:puts).with("Welcome to the music library manager!\nWhat would you like to do?\n1 - List all albums\n2 - List all artists")
            expect(io).to receive(:puts).with("Enter your choice:")
            expect(io).to receive(:gets).and_return("oops")
            expect(io).to receive(:puts).with("Please only enter '1' or '2'")
            expect(io).to receive(:puts).with("Enter your choice:")
            expect(io).to receive(:gets).and_return("1")
            expect(io).to receive(:puts).with("1 - Bossanova\n2 - Surfer Rosa")

            app.run 
        end

    end
end

