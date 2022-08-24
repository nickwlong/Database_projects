require 'artist'
require 'artist_repository'


RSpec.describe ArtistRepository do
    def reset_artists_table
        seed_sql = File.read('spec/seeds_artists.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_artists_table
    end


    it '' do
        repo = ArtistRepository.new
        artists = repo.all
        expect(artists.length).to eq 2
        expect(artists.first.id).to eq '1'
        expect(artists.first.name).to eq 'Pixies'
    end

    it 'creates a new artist' do
        repository = ArtistRepository.new

        new_artist = Artist.new
        new_artist.name = 'The Beatles'
        new_artist.genre = 'Pop'

        repository.create(new_artist)

        all_artists = repository.all # => should include artist

        last_artist = all_artists.last
        expect(last_artist.name).to eq 'The Beatles'
        expect(last_artist.genre).to eq 'Pop'
    end

    it 'deletes an artist' do
        repo = ArtistRepository.new

        id_to_delete = 1

        repo.delete(id_to_delete)

        all_artists = repo.all
        expect(all_artists.length).to eq 1
        expect(all_artists.first.id).to eq '2'
    end


    it 'deletes both artists' do
        repo = ArtistRepository.new

        id_to_delete = 1

        repo.delete(id_to_delete)
        repo.delete(2)

        all_artists = repo.all
        expect(all_artists.length).to eq 0
    end

    it 'updates an artist to a new name' do
        repo = ArtistRepository.new

        artist = repo.find(1)
        
        artist.name = 'Oops'
        artist.genre = 'Disco'
        
        repo.update(artist)
        all_artists = repo.all
        updated_artist = repo.find(1)

        expect(all_artists.length).to eq 2

        expect(updated_artist.name).to eq 'Oops'
        expect(updated_artist.genre).to eq 'Disco'
    end
end