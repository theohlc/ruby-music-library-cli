class MusicImporter
    attr_reader :path

    def initialize (path)
        @path = path
    end

    def files
        Dir.entries(path).select { |f| File.file? File.join(path, f)}
    end

    def import
        files.each do |file|
            Song.create_from_filename(file)
        end
    end
end