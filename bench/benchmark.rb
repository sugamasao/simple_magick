require 'benchmark'
require 'fileutils'
require 'simple_magick'
require 'mini_magick'

simple_magick_dir = File.join(__dir__, 'tmp', 'simple_magick')
mini_magick_dir   = File.join(__dir__, 'tmp', 'mini_magick')
image_magick_dir  = File.join(__dir__, 'tmp', 'image_magick')

[mini_magick_dir, simple_magick_dir, image_magick_dir].each do |dir|
  FileUtils.mkdir_p dir unless File.directory? dir
end

sample_image = File.join('..', 'spec', 'assets', 'sample.jpg')

n = 100
Benchmark.bm(15) do |x|
  x.report('simple_magick') {
    n.times do |count|
      image = SimpleMagick::Image.new(sample_image)
      image.resize '150x150'
      image.quality '50'
      image.convert! File.join(simple_magick_dir, "image_#{count}.jpg")
    end
  }

  x.report('mini_magick') {
    n.times do |count|
      image = MiniMagick::Image.open(sample_image)
      image.resize '150x150'
      image.quality '50'
      image.write File.join(mini_magick_dir, "image_#{count}.jpg")
    end
  }

  x.report('ImageMagick') {
    n.times do |count|
      result_image = File.join(image_magick_dir, "image_#{count}.jpg")
      FileUtils.cp(sample_image, result_image)
      `mogrify -resize 150x150 -quality 50 #{result_image}`
    end
  }
end
