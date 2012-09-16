require 'mime/types'
require 'pathname'
require 'open-uri'

module Uplodar

  class FsManager
    attr_reader :share, :path, 
      :current_path, :current_url, :current_lpath, 
      :breadcrumps, :dirs, :files

    def initialize(share, path = nil)
      @share, @path = share, path
      setup
    end

    def setup
      make_currents
      make_breadcrumbs
      make_list
    end

    def entries
      @dirs.concat(files)
    end

    def make_file_obj(file)
      pname = Pathname.new(file)
      ptype = pname.ftype

      return nil unless ['directory', 'file'].include? ptype

      { :name => pname.basename, :type => ptype, :size => pname.size } 
    end


    def self.make_dir(path, dir)
      new_dir = File.join(path, dir)

      return nil if !self.valid_path?(new_dir)
      return nil if File.exists? new_dir

      Dir.mkdir(new_dir)
    end

    def self.save_file(path, file)
      return nil unless File.exists? path

      tmp      = File.join(path, file.original_filename)
      new_file = tmp
      cntr     = 1

      while File.exists? new_file
        new_file = "#{tmp}.#{cntr}"
        cntr += 1
      end

      return nil if !self.valid_path?(new_file)

      File.open(new_file, "wb") {|f| f.write( file.read ) }
    end

    def self.move(old, new)
      return false if !File.exist? old
      return false if File.exist? new

      return nil if !self.valid_path?(old)
      return nil if !self.valid_path?(new)

      FileUtils.mv(old, new)
    end

    def self.delete(path, entry)
      tmp = File.join(path, entry)

      return nil if !self.valid_path?(tmp)

      FileUtils.rm_rf(tmp) if File.exists? tmp
    end

    private

    def make_currents
      if @path.blank?
        @current_path  = @share.path
        @current_url   = @share.url
        @current_lpath = @share.name
      else
        @current_path  = File.join(@share.path, @path)
        @current_url   = File.join(@share.url, @path)
        @current_lpath = File.join(@share.name, @path)
      end

      @current_url = URI::encode(@current_url)
    end

    def make_breadcrumbs
      @breadcrumps = @current_lpath.split('/')
    end

    def make_list
      @dirs = []
      @files = []

      Dir.glob("#{@current_path}/*").sort.each do |file|
        file_obj = make_file_obj(file)
        next if file_obj.blank?

        case file_obj[:type]
        when  'directory' then @dirs  << file_obj
        when  'file'      then @files << file_obj
        end

      end
    end

    def detect_mime(file)
      tmp = MIME::Types.type_for(file)
      return "unknown" if tmp.empty?

      case tmp.first.content_type
      when "video/x-msvideo", "video/quicktime", "video/vnd.objectvideo", "application/mp4"
        "video"
      when "audio/mpeg", "audio/x-wav"
        "audio"
      when "image/png", "image/jpeg"
        "image"
      when  "application/x-bzip2",  "application/x-gzip", 
        "application/zip",      "application/x-rar-compressed",
        "application/x-gtar"
        "archive"
      when "application/pdf"
        "pdf"
      when "application/octet-stream"
        "binary"
      else
        tmp.first.content_type
      end
    end

    def self.valid_path?(path)
      path == Pathname.new(path).cleanpath.to_s
    end

  end
end
