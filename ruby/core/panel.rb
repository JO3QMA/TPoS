# frozen_string_literal: true

require 'rmagick'

# 画像を複数枚結合する方
class Panel
  attr_writer :posters, :col, :row, :dummy, :separate_count

  def initialize
    @posters = []
    @col = 4
    @row = 4 * 2 # 2枚一組で生成するため、倍の長さが必要
    @separate_count = 4
  end

  # ダミーで不足分を埋める
  def fill_dummy
    target_poster = @col * @row
    if target_poster.size > @posters.size
      fill_count = target_poster_size - @posters.size
      puts 'INFO : ポスターの枚数が目標値に足らないため、ダミーデータで埋められます。'
      fill_count.times do
        @posters << @dummy
      end
    elsif @posters.size > target_poster_size
      warn 'ERROR: ポスターの枚数が、目標値を超えています。'
    end
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
