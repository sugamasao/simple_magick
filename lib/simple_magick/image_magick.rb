module SimpleMagick

  # Don't manually modified!! (generate by $ rake generate_option)
  # Generate Date 2014-03-11 23:34:56 +0900
  # ImageMagick Version: ImageMagick 6.8.7-7 Q16 x86_64 2013-11-27 
  module ImageMagick
    EXEC = 'mogrify'

    OPTIONS = %w(
adaptive-blur adaptive-resize adaptive-sharpen adjoin affine
affinity alpha alpha annotate antialias
append attenuate authenticate auto-gamma auto-level
auto-orient background bench bias black-threshold
blue-primary blue-shift blur border bordercolor
bordercolor brightness-contrast caption cdl cdl
channel charcoal chop clamp clip
clip-mask clip-path clut coalesce color-matrix
colorize colors colorspace combine comment
compare complex compose composite compress
contrast contrast-stretch convolve crop cycle
debug decipher decipher deconstruct define
delay delete density depth deskew
despeckle direction display dispose distort
distribute-cache dither draw duplicate edge
emboss encipher encipher encoding endian
enhance equalize evaluate evaluate-sequence extent
extract family features features fft
fill filter flatten flatten flip
floodfill flop font format frame
function function fuzz fx gamma
gaussian-blur geometry gravity grayscale green-primary
hald-clut help help identify ift
implode insert intensity intent interlace
interline-spacing interpolate interword-spacing kerning label
lat layers layers level level-colors
limit linear-stretch liquid-rescale list log
loop magnify mask matte mattecolor
median mode modulate monitor monochrome
morph morphology morphology mosaic motion-blur
negate noise normalize opaque ordered-dither
orient page paint path perceptible
ping pointsize polaroid poly posterize
precision preview print process profile
quality quantize quiet radial-blur raise
random-threshold red-primary regard-warnings region remap
render repage resample resize respect-parentheses
reverse roll rotate sample sampling-factor
scale scene seed segment selective-blur
separate sepia-tone set shade shadow
sharpen shave shear sigmoidal-contrast size
sketch smush solarize sparse-color splice
spread statistic stretch strip stroke
strokewidth style swap swirl synchronize
taint texture threshold thumbnail tile
tile-offset tint transform transparent transparent-color
transpose transverse treedepth trim type
undercolor unique-colors units unsharp verbose
version view vignette virtual-pixel wave
weight white-point white-threshold write
    )
  end
end
