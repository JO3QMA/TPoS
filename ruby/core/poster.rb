# frozen_string_literal: true

require 'rmagick'

# ポスタークラス(広告一枚一枚のほう)
class Poster
  # 初期化
  def initialize(path)
    puts "DEBUG: #{path}を読み込み"
    @path = path
    @image = Magick::Image.read(path).first
  end

  def resize(size)
    puts "DEBUG: #{@path}をリサイズ"
    @image.resize(size[0], size[1])
  end
end
