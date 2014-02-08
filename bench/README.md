# benchmark

Setup.

```
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

## Spec

- OSX 10.8.5
- CPU: 2.53 GHz Intel Core i5
- Memory: 8GB

## version

- ruby 2.1.0p0 (2013-12-25 revision 44422) [x86_64-darwin12.0]
- mini_magick (3.7.0)
- simple_magick (0.0.2)
- ImageMagick 6.8.7-7
