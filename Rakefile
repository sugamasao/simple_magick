require 'bundler/gem_tasks'
require 'pathname'

desc 'generate SimpleMagick DATA of mogrify option'
task :generate_option do |t|
  version_string = `mogrify -version`
  version_line   = version_string.split("\n").first
  version_line   =~ /\AVersion:\s(.+\s.+\s.+\s.+\s)/
  version        = $1

  options_string = `mogrify`
  options = options_string.split("\n").map { |line|
    if line.strip =~ /\A-(\w.+?)\s/
      $1
    end
  }.compact.sort

  image_magick = ''
  image_magick << <<EOS
module SimpleMagick

  # Don't manually modified!! (generate by $ rake generate_option)
  # Generate Date #{Time.now}
  # ImageMagick Version: #{version}
  module ImageMagick
    EXEC = 'mogrify'

    OPTIONS = %w(
EOS
  options.each_slice(5) do |opt|
    image_magick << opt.join(' ')
    image_magick << "\n"
  end
  image_magick << <<EOS
    )
  end
end
EOS

  image_magick_path = Pathname(__dir__).join('lib', 'simple_magick', 'image_magick.rb').expand_path
  File.open(image_magick_path, 'w') do |file|
    file.puts image_magick
  end
  puts "Generate File ImageMagick Options. (#{image_magick_path})"
end
