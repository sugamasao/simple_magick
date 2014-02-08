require 'spec_helper'
require 'fileutils'

describe SimpleMagick do

  describe '.imagemagick_installed?' do
    it 'installed ImageMagick' do
      expect(SimpleMagick).to be_imagemagick_installed
    end
  end

  describe SimpleMagick::Image do
    describe '#convert!' do
      let(:asset_path) { File.join(__dir__, 'assets', 'sample.jpg') }
      let(:result_path) { File.join(__dir__, 'assets', 'result', 'resize.jpg') }

      before do
        result_dir = File.dirname(result_path)
        FileUtils.rm_r(result_dir) if File.directory?(result_dir)
      end

      context 'Resize Image' do
        it 'Resize Success' do
          image = SimpleMagick::Image.new(asset_path)
          image.resize '150x'
          image.quality '60'
          image.convert! result_path
          expect(File).to be_file(result_path)
        end
      end

      context 'Not Found assets_path' do
        let(:not_found_path) { asset_path + '.not_found_ext' }
        it 'raise SimpleMagick::ConvertError' do
          image = SimpleMagick::Image.new(not_found_path)
          image.resize '150x'
          image.quality '60'
          expect {
            image.convert! result_path
          }.to raise_error(SimpleMagick::ConvertError, /Not Found/)
        end
      end

    end
  end

end
