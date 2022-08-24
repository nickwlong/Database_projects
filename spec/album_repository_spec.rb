require 'album_repository'

RSpec.describe AlbumRepository do
    def reset_albums_table
        seed_sql = File.read('spec/seeds_albums.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end
      
    before(:each) do 
        reset_albums_table
    end


    it '#all returns a list of albums as objects' do
        repo = AlbumRepository.new

        albums = repo.all

        expect(albums.length).to eq 2

        expect(albums[0].id).to eq '1'
        expect(albums[0].title).to eq 'Bossanova'
        expect(albums[0].release_year).to eq '1999'
        expect(albums[0].artist_id).to eq '1'

        expect(albums[1].id).to eq '2'
        expect(albums[1].title).to eq 'Surfer Rosa'
        expect(albums[1].release_year).to eq '2001'
        expect(albums[1].artist_id).to eq '1'
    end

    it '' do

        repo = AlbumRepository.new

        album = repo.find('1')
        expect(album.id).to eq '1'
        expect(album.title).to eq 'Bossanova'
        expect(album.release_year).to eq '1999'
    end

    describe "#create" do
        it 'Adds album and checks it is in the database' do
            repository = AlbumRepository.new

            album = Album.new
            album.title = 'Trompe le Monde'
            album.release_year = '1991'
            album.artist_id = '1'

            repository.create(album)

            all_albums = repository.all # => should include album

            expect(all_albums).to include(have_attributes(title: album.title, release_year: album.release_year))
        end
    end
end