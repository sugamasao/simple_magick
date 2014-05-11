require 'spec_helper'
require 'fileutils'

describe SimpleMagick do

  describe '.imagemagick_installed?' do
    it 'installed ImageMagick' do
      expect(SimpleMagick).to be_imagemagick_installed
    end
  end

  describe SimpleMagick::Image do
    describe '#additional_command' do
      context 'command and value' do
        let(:asset_path) { File.join(__dir__, 'assets', 'sample.jpg') }

        it 'set option and value' do
          image = SimpleMagick::Image.new(asset_path)
          expect(image.additional_option('type', 'Grayscale').last).to eq '-type "Grayscale"'
        end

        it 'set only option' do
          image = SimpleMagick::Image.new(asset_path)
          expect(image.additional_option('version').last).to eq '-version'
        end
      end
    end

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

      context 'create command remove ShellEscape and quote option' do
        context '#3 draw option filed' do
          let(:asset_path) { File.join(__dir__, 'assets', 'sample.jpg') }
          let(:result_path) { File.join(__dir__, 'assets', 'result', 'resize.jpg') }

          before do
            result_dir = File.dirname(result_path)
            FileUtils.rm_r(result_dir) if File.directory?(result_dir)
          end

          it 'draw option Success' do
            image = SimpleMagick::Image.new(asset_path)
            image.draw 'stroke #0000ff stroke-width 2 fill-opacity 0.0 rectangle 10,10 100,100'
            image.convert! result_path
            expect(File).to be_file(result_path)
          end
        end

        context '#2 Windows filename type 8.1 filed(only windows)' do
          let(:asset_path) { File.join(__dir__, 'assets', 'sample.jpg') }
          let(:result_path) { File.join(__dir__, 'assets', 'result', 'AAA123~1.jpg') }

          context 'Windows OS' do
            before do
              result_dir = File.dirname(result_path)
              FileUtils.rm_r(result_dir) if File.directory?(result_dir)
              SimpleMagick::Utility.stub(:windows?) { true }
            end

            it 'convert! success' do
              image = SimpleMagick::Image.new(asset_path)
              image.resize '150x'
              expect(image.convert!(result_path).split(' ').last).to eq result_path
              expect(File).to be_file(result_path)
            end
          end

          context 'Not Windows OS' do
            before do
              result_dir = File.dirname(result_path)
              FileUtils.rm_r(result_dir) if File.directory?(result_dir)
              SimpleMagick::Utility.stub(:windows?) { false }
            end

            it 'convert! success' do
              image = SimpleMagick::Image.new(asset_path)
              image.resize '150x'
              expect(image.convert!(result_path).split(' ').last).to eq Shellwords.escape(result_path)
              expect(File).to be_file(result_path)
            end
          end
        end
      end
    end
  end

end