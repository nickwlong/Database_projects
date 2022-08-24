require_relative './album.rb'

class AlbumRepository
    def all
        sql = 'SELECT id, title, release_year, artist_id FROM albums;'
        result_set = DatabaseConnection.exec_params(sql, [])

        albums = []

        result_set.each do |record|
            album = Album.new
            album.id = record['id']
            album.title = record['title']
            album.release_year = record['release_year']
            album.artist_id = record['artist_id']

            albums << album
        end
        return albums
    end

    def find(id)
        # The placeholder $1 is a "parameter" of the SQL query.
        # It needs to be matched to the corresponding element 
        # of the array given in second argument to exec_params.
        #
        # (If we needed more parameters, we would call them $2, $3...
        # and would need the same number of values in the params array).
        sql = 'SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
    
        params = [id]
    
        result_set = DatabaseConnection.exec_params(sql, params)
        result_set.each do |record|
            album = Album.new
            album.id = record['id']
            album.title = record['title']
            album.release_year = record['release_year']
            album.artist_id = record['artist_id']
            return album
        end
    end

    def create(album)
        sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3)'
        params = [album.title, album.release_year, album.artist_id]

        DatabaseConnection.exec_params(sql, params)
        return nil

    end


end