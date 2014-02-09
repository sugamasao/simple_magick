# SimpleMagick

SimpleMagick is Ultra Simple ImageMagick Wrapper.

## Installation(Dependency)

requirements ImageMagick(use mogrify command)

```
% brew install imagemagick
```

## Installation

Add this line to your application's Gemfile:

    gem 'simple_magick', github: 'sugamasao/simple_magick'

And then execute:

    $ bundle

## Supported versions

 - Ruby 2.0.0, 2.1.0

## Usage

```ruby
require 'simple_magick'

if SimpleMagick.imagemagick_installed?
  image = SimpleMagick::Image.new('/path/to/src_image.jpg')
  image.resize '150x150'
  image.convert! '/path/to/dest_image.jpg'
end
```

## Benchmark

### Benchmark Spec

- OSX 10.8.5
- CPU: 2.53 GHz Intel Core i5
- Memory: 8GB

### Version

- ruby 2.1.0p0 (2013-12-25 revision 44422) [x86_64-darwin12.0]
- mini_magick (3.7.0)
- simple_magick (0.0.2)
- ImageMagick 6.8.7-7

### How To Benchmark

Setup.

```
% cd benchmark
% brew install imagemagick
% bundle install
```

exec.

```sh
% bundle exec ruby benchmark.rb
                      user     system      total        real
simple_magick     0.080000   0.270000  28.530000 ( 29.687068)
mini_magick       0.410000   0.790000  31.300000 ( 37.115507)
ImageMagick       0.030000   0.170000  28.620000 ( 29.094316)
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/simple_magick/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
