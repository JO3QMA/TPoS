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
end
