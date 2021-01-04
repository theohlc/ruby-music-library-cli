require 'pry'

class Genre
    extend Concerns::Findable

    attr_accessor  :name
    attr_reader :songs

    @@all = []

    def initialize(name)
        if name == "hip"
            name = "hip-hop"
            #binding.pry
        end 
        @name = name
        @songs = []
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
        genre = new(name)
        genre.save
        genre
    end


    #shared with artist class
    def add_song(song)
        if !song.genre
            song.set_genre(self)
            songs << song
        end
    end

    def artists
        songs.collect{|song| song.artist}.uniq
    end
end