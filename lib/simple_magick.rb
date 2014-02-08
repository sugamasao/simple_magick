require 'simple_magick/version'
require 'fileutils'
require 'open3'
require 'shellwords'

module SimpleMagick
  class ConvertError < StandardError;end

  # mogrify is ImageMagick family tool.
  # @note Windows Not Supported
  # @return [Boolean] find mogrify command is true
  def self.imagemagick_installed?
    !`which mogrify`.split("\n").first.nil?
  end

  # Convert Image Class.
  # @example Usage
  #   image = SimpleMagick::Image.new('/path/to/org.jpg')
  #   image.resize '150x'
  #   image.convert!('/path/to/thumb.jpg')
  class Image

    # @param [String] source_path Target Image File Path
    # @param [Boolean] verbose print detailed information
    def initialize(source_path, verbose = false)
      @source_path = source_path
      @verbose     = verbose
      @command     = ['mogrify']
    end

    # @param [String] size resize size
    def resize(size)
      @command << "-resize #{Shellwords.escape(size)}"
    end

    # @param [String] num image quality
    def quality(num)
      @command << "-quality #{Shellwords.escape(num)}"
    end

    # @param [String] string define string.
    def define(string)
      @command << "-define #{Shellwords.escape(string)}"
    end

    # run ImageMagick.
    # @param [String] destination_path output image path
    # @return [Void]
    # @raise [SimpleMagick::ConvertError] mogrify command fail.
    def convert!(destination_path)
      file_copy(destination_path)
      command = create_command(@command, destination_path)

      # ex. % mogrify -resize 90 /path/to/resized_image.jpg
      begin
        puts "[INFO] #{command}" if @verbose
        stdout, stderr, status = Open3.capture3(command)
      rescue SystemCallError => e
        raise ConvertError.new("mogrify error. exec command => [#{command}], Error Detail => [#{e.message}]")
      end

      unless status.success?
        raise ConvertError.new("mogrify error. exec command => [#{command}], stdout => [#{stdout}], stderr => [#{stderr}]")
      end
    end

    private

    # copy source_path to destination_path
    # @param [String] destination_path
    # @return [Void]
    # @raise [SimpleMagick::ConvertError] @source_path not found.
    def file_copy(destination_path)
      unless File.file? @source_path
        raise ConvertError.new("Not Found intput file. input file => [#{@source_path}]")
      end

      dest_dir = File.dirname(destination_path)
      FileUtils.mkdir_p(dest_dir)
      puts "[INFO] cp #{@source_path} #{destination_path}" if @verbose
      FileUtils.cp(@source_path, destination_path)
    end

    # create exec command line
    # @param [Array] command mogrify command
    # @param [String] destination_path create image path
    # @return [String] command String.
    def create_command(command, destination_path)
      command << Shellwords.escape(destination_path)
      command.join(' ')
    end
  end
end
