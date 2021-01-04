require 'pry'

class Song
    #extend Concerns::Findable

    attr_accessor  :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        if artist
            self.artist = artist
        end
        if genre
            if genre == "hip"
                binding.pry
            end
            self.genre = genre
        end
    end

    def self.all
        @@all
    end
    
    def save
        @@all << self
    end

    def self.destroy_all
        @@all = []
    end

    def self.create(name)
        song = new(name)
        song.save
        song
    end

    def self.find_by_name(name)
        @@all.find{ |song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    #methods unique to song class

    def set_artist(artist)
        @artist = artist
    end

    def artist=(artist)
        artist.add_song(self)
    end

    def set_genre(genre)
        @genre = genre
    end

    def genre=(genre)
        genre.add_song(self)
    end

    def self.new_from_filename(filename)
        name_array = filename.split(/[-.]/)

        song = self.new(name_array[1].strip)
        artist = Artist.find_or_create_by_name(name_array[0].strip)
        genre = Genre.find_or_create_by_name(name_array[2].strip)
        song.artist= artist
        song.genre= genre
        song
    end

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        song.save
    end
end