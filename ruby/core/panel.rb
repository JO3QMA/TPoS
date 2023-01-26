# frozen_string_literal: true

require 'rmagick'

# 画像を複数枚結合する方
class Panel
  attr_reader :posters

  def initialize(posters, config)
    @posters = posters
    @config = config
    fill_dummy
  end

  # ダミーで不足分を埋める
  def fill_dummy
    dummy = Array.new(@config.slice - @posters.size, @config.dummy)
    @posters.concat(dummy)
  end

  # 左右で分割します。 @separate_count毎に分けられます。
  def separate
    @panels = { left: [], right: [] }
    separate_posters = @posters.each_slice(@separate_count).to_a
    separate_posters.each_with_index do |column, i|
      if i.even?
        @panels[:right] << column
      else
        @panels[:left] << column
      end
    end
  end

  def render; end
end
