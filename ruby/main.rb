# frozen_string_literal: true

require_relative './core/config'
require_relative './core/panel'
require_relative './core/poster'
require_relative './core/img_loader'

config_path = if ARGV.size.zero?
                './config.yml'
              elsif ARGV.size == 1
                ARGV[0]
              else
                warn 'ERROR: Too many arguments.'
                exit(false)
              end

if __FILE__ == $PROGRAM_NAME
  config = Config.new(config_path)
  images = ImgLoader.new(config)
  images.list
  puts images.wanted_posters

end
