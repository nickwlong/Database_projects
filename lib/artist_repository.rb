require_relative './artist.rb'

class ArtistRepository
    def all
        sql = 'SELECT id, name, genre FROM artists;'
        result_set = DatabaseConnection.exec_params(sql, [])
        
        artists = []

        result_set.each do |record|
            artist = Artist.new
            artist.id = record['id']
            artist.name = record['name']
            artist.genre = record['genre']
            artists << artist
        end
    
        return artists        
    end

    def find(id)
        # The placeholder $1 is a "parameter" of the SQL query.
        # It needs to be matched to the corresponding element 
        # of the array given in second argument to exec_params.
        #
        # (If we needed more parameters, we would call them $2, $3...
        # and would need the same number of values in the params array).
        sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    
        params = [id]
    
        result_set = DatabaseConnection.exec_params(sql, params)
        result_set.each do |record|
            artist = Artist.new
            artist.id = record['id']
            artist.name = record['name']
            artist.genre = record['genre']
            return artist
        end
    end

    def create(artist)
        sql = 'INSERT INTO artists (name, genre) VALUES ($1, $2);'
        sql_params = [artist.name, artist.genre]

        DatabaseConnection.exec_params(sql, sql_params)
        return nil

    end

    def delete(id)
        sql = 'DELETE FROM artists WHERE id = $1'
        params = [id]
        DatabaseConnection.exec_params(sql, params)
    end

    def update(artist)
        sql = 'UPDATE artists SET name = $1, genre = $2 WHERE id = $3;'
        sql_params = [artist.name, artist.genre, artist.id]

        DatabaseConnection.exec_params(sql, sql_params)
        return nil
    end

end