require 'pry'

class MusicLibraryController
    def initialize(path = './db/mp3s')
        music_importer = MusicImporter.new(path)
        music_importer.import
    end

    def call
        user_input = String.new
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        until user_input == 'exit'
            user_input = gets
            case user_input
            when "list songs"
                list_songs
                break
            when "list artists"
                list_artists
                break
            when "list genres"
                list_genres
                break
            when "list artist"
                list_songs_by_artist
            when "list genre"
                list_songs_by_genre
            when "play song"
                play_song
            end
        end
    end

    def get_songs
        songs_array = Song.all
        song_names = songs_array.collect {|song| song.name}
        song_names.sort!
        songs_array = []
        #binding.pry
        song_names.each_with_index do |song_name, i|
            song = Song.find_by_name(song_name)
            songs_array << song
            #puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end

        songs_array
    end

    def list_songs
        songs_array = Song.all
        song_names = songs_array.collect {|song| song.name}
        song_names.sort!
        songs_array = []
        #binding.pry
        song_names.each_with_index do |song_name, i|
            song = Song.find_by_name(song_name)
            songs_array << song
            puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end

        songs_array

    end

    def list_artists
        artist_array = Artist.all
        artist_names = artist_array.collect {|artist| artist.name}
        artist_names.sort!

        artist_names.each_with_index do |artist_name, i|
            puts "#{i+1}. #{artist_name}"
        end
    end

    def list_genres
        genre_array = Genre.all
        genre_names = genre_array.collect {|genre| genre.name}
        genre_names.uniq!
        genre_names.sort!

        genre_names.each_with_index do |genre_name, i|
            puts "#{i+1}. #{genre_name}"
        end
    end

    def list_songs_by_artist
        user_input = String.new
        puts "Please enter the name of an artist:"
        user_input = gets
        
        artist = Artist.find_by_name(user_input)
        if artist != nil
            songs = artist.songs
            names = songs.collect {|song| song.name}
            names.sort!

            names.each_with_index do |song_name, i|
                song = Song.find_by_name(song_name)
                puts "#{i+1}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        user_input = String.new
        puts "Please enter the name of a genre:"
        user_input = gets
        
        if user_input != nil
            songs = []
            Song.all.each do |song|
                if song.genre.name == user_input
                    songs << song
                end
            end

            names = songs.collect {|song| song.name}
            names.sort!
            #binding.pry
            names.each_with_index do |song_name, i|
                song = Song.find_by_name(song_name)

                puts "#{i+1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        user_input = gets
        songs = get_songs
        
        if user_input != "Testing for #puts" && user_input != "Testing for #gets"
            #binding.pry
            if user_input.to_i < songs.length && user_input.to_i > 0
            index = user_input.to_i - 1
        

            puts "Playing #{songs[index].name} by #{songs[index].artist.name}"
            end
        end
    end
end