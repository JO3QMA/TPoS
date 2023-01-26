# frozen_string_literal: true

require 'yaml'

# Configration Class
class Config
  def initialize(path)
    @config = YAML.load_file(path)
  end

  # ポスター関連
  def source
    @config['posters']['source']
  end

  def pattern
    @config['posters']['pattern']
  end

  def dummy
    @config['posters']['dummy']
  end

  def slice
    @config['posters']['slice']
  end

  def wanted
    @config['posters']['wanted']
  end
end
