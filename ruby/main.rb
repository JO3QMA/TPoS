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
  puts 'INFO : 処理を開始します。。。'
  config = Config.new(config_path)
  puts 'INFO : 設定ファイルを読み込みました。'
  images = ImgLoader.new
  images.config = config
  puts "INFO : ポスターの枚数 #{images.list.size}枚"
  panels = []
  images.list.each_slice(config.slice).with_index do |img, idx|
    puts "INFO : #{idx + 1}枚目 ポスターの生成を開始します。"
    panels[idx] = Panel.new(img, config)
    panels[idx].render
  end
  puts panels
  puts images.wanted_posters.size
end
