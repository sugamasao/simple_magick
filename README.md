# SimpleMagick

SimpleMagick is Ultra Simple ImageMagick Wrapper.

## Installation(Dependency)

requirements ImageMagick(use mogrify command)

```
% brew install imagemagick
```

## Installation

Add this line to your application's Gemfile:

    gem 'simple_magick'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_magick

## Usage

```ruby
require 'simple_magick'

if SimpleMagick.imagemagick_installed?
  image = SimpleMagick::Image.new('/path/to/src_image.jpg')
  image.resize '150x150'
  image.convert! '/path/to/dest_image.jpg'
end
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/simple_magick/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
