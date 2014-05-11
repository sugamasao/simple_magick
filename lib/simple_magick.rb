require 'simple_magick/version'
require 'simple_magick/image_magick'
require 'simple_magick/utility'
require 'fileutils'
require 'open3'
require 'shellwords'

module SimpleMagick
  class ConvertError < StandardError;end

  # mogrify is ImageMagick family tool.
  # @note Windows Not Supported
  # @return [Boolean] find mogrify command is true
  def self.imagemagick_installed?
    !`which #{ImageMagick::EXEC}`.split("\n").first.nil? unless Utility.windows?
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
      @command     = [ImageMagick::EXEC]
    end

    # set option
    def method_missing(method, *args)
      super unless ImageMagick::OPTIONS.include? method.to_s
      __send__(:additional_option, method.to_s, args[0])
    end

    # use options.
    # @param [String] option option name
    # @param [String] value option value. default = ''
    def additional_option(option, value = '')
      value = value.strip
      @command << %Q(-#{option}).strip
      @command.last << %Q( "#{value}") unless value.empty?
      @command
    end

    # run ImageMagick.
    # @param [String] destination_path output image path
    # @return [String] execute command
    # @raise [SimpleMagick::ConvertError] mogrify command fail.
    def convert!(destination_path)
      file_copy(destination_path)
      command = create_command(@command, destination_path)

      # ex. % mogrify -resize 90 /path/to/resize_image.jpg
      begin
        puts "[INFO] #{command}" if @verbose
        stdout, stderr, status = Open3.capture3(command)
      rescue SystemCallError => e
        raise ConvertError.new("#{ImageMagick::EXEC} error. exec command => [#{command}], Error Detail => [#{e.message}]")
      end

      unless status.success?
        raise ConvertError.new("#{ImageMagick::EXEC} error. exec command => [#{command}], stdout => [#{stdout}], stderr => [#{stderr}]")
      end

      command
    end

    private

    # copy source_path to destination_path
    # @param [String] destination_path
    # @return [Void]
    # @raise [SimpleMagick::ConvertError] @source_path not found.
    def file_copy(destination_path)
      unless File.file? @source_path
        raise ConvertError.new("Not Found input file. input file => [#{@source_path}]")
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
      if Utility.windows?
        command << destination_path
      else
        command << Shellwords.escape(destination_path)
      end
      command.join(' ')
    end
  end
end
