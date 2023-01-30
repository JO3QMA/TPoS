# frozen_string_literal: true

require_relative './core/config'
require_relative './core/panel'
require_relative './core/poster'
require_relative './core/img_loader'

# 設定ファイルのパス
def config_path
  if ARGV.size.zero?
    './config.yml'
  elsif ARGV.size == 1
    ARGV[0]
  else
    warn 'ERROR: 引数が多すぎます。引数に使えるのは設定ファイルのパスのみです！'
    exit(false)
  end
end

# Main
if __FILE__ == $PROGRAM_NAME
  config = Config.new(config_path)
  puts 'INFO : 設定ファイルを読み込みました。'
  images = ImgLoader.new
  images.config = config
  puts "INFO : ポスターの枚数 #{images.list.size}枚"
  images.list.each_slice(config.slice).with_index(1) do |img, i|
    i = format('%02<number>d', number: i)
    puts "INFO : #{i}枚目 ポスターの生成を開始します。"
    panel = Panel.new(img, config, i)
    panel.render
  end
  puts 'INFO : 募集ポスターの生成を開始します。'
  wanted = Panel.new(images.wanted_posters, config, 'latest')
  wanted.render
end
