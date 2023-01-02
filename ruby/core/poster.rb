# frozen_string_literal: true

require 'rmagick'

# ポスタークラス(広告一枚一枚のほう)
class Poster
  attr_writer :width, :height, :margin, :margin_color

  # 初期化
  def initialize(path)
    @img = Magick::Image.read(path).first
    @width = 256
    @height = 512
    @margin = 64
    @margin_color = 'transparent'
  end

  def render
    image = @img.resize(@width, @height)
    image.border(@margin, @margin, @margin_color)
  end
end
