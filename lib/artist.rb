

class Artist
    extend Concerns::Findable

    attr_accessor  :name
    attr_reader :songs

    @@all = []

    def initialize(name)
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
        artist = new(name)
        artist.save
        artist
    end

    #shared w/ genre
    def add_song(song)
        if !song.artist
            song.set_artist(self)
            songs << song
        end
    end

    #methods unique to artist class:

    def genres
        songs.collect{|song| song.genre}.uniq
    end

end