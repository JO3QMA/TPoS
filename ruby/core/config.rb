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

  def target
    File.expand_path(@config['posters']['target'])
  end

  def extension
    @config['posters']['extension']
  end

  def format
    @config['posters']['format']
  end

  def dummy
    File.expand_path(@config['posters']['dummy'])
  end

  def wanted
    File.expand_path(@config['posters']['wanted'])
  end

  def slice
    tile = @config['montage']['tile'].split('x')
    { col: tile[0].to_i, row: tile[1].to_i }
  end

  def slice_panel
    slice[:col] * slice[:row]
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
    options['geometry'] = Magick::Geometry.new(
      size[0], size[1],
      config['geometry']['distance'],
      config['geometry']['distance']
    )
    options['tile'] = config['tile']
    options
  end
end
