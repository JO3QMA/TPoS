# frozen_string_literal: true

require 'yaml'

# Configration Class
class Config
  def initialize(path)
    @config = YAML.load_file(path)
  end

  # ポスター関連
  def pattern
    @config.dig('posters', 'pattern')
  end

  def source
    File.expand_path(@config.dig('posters', 'source'))
  end

  def target
    File.expand_path(@config.dig('posters', 'target'))
  end

  def extension
    @config.dig('posters', 'extension')
  end

  def format
    @config.dig('posters', 'format')
  end

  def dummy
    File.expand_path(@config.dig('posters', 'dummy'))
  end

  def wanted
    File.expand_path(@config.dig('posters', 'wanted'))
  end

  def slice
    tile = @config.dig('montage', 'tile').split('x')
    { col: tile[0].to_i, row: tile[1].to_i }
  end

  def slice_panel
    slice[:col] * slice[:row]
  end

  def size
    width = @config.dig('posters', 'size', 'width')
    height = @config.dig('posters', 'size', 'height')
    [width, height]
  end

  # モンタージュ
  def montage
    config = @config['montage']
    options = {}
    options['background_color'] = config['background_color']
    options['geometry'] = Magick::Geometry.new(
      size[0], size[1],
      config.dig('geometry', 'distance'),
      config.dig('geometry', 'distance')
    )
    options['tile'] = config['tile']
    options
  end
end
