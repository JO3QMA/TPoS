# frozen_string_literal: true

require 'yaml'

# Configration Class
class Config
  def initialize(path)
    @config = YAML.load_file(path)
  end

  # ポスター関連
  def pattern
    @config['posters']['pattern']
  end

  def source
    File.expand_path(@config['posters']['source'])
  end

  def dummy
    File.expand_path(@config['posters']['dummy'])
  end

  def wanted
    File.expand_path(@config['posters']['wanted'])
  end

  def slice
    @config['posters']['slice']
  end

  def size
    width = @config['posters']['size']['width']
    height = @config['posters']['size']['height']
    [width, height]
  end

  # モンタージュ
  def montage
    config = @config['montage']
    options = {}
    options['background_color'] = config['background_color']
    options['geometry'] =
Magick::Geometry.new(config['geometry']['width'], config['geometry']['height'], config['geometry']['distance'],
                     config['geometry']['distance'])
    options['tile'] = config['tile']

    options
  end
end
