# frozen_string_literal: true

require 'rmagick'

# 画像を複数枚結合する方
class Panel
  attr_reader :posters

  def initialize(posters, config, index)
    @posters = posters
    @config = config
    @index = index
    fill_dummy
    separate
  end

  # ダミーで不足分を埋める
  def fill_dummy
    puts "INFO : ポスターの枚数 #{@posters.size}枚"
    return unless @posters.size < @config.slice

    puts "INFO : #{@config.slice}に満たない分はダミーデータで補われます。"
    dummy = Array.new(@config.slice - @posters.size, @config.dummy)
    @posters.concat(dummy)
  end

  # 左右で分割します。 @separate_count毎に分けられます。
  def separate
    @panels = { left: [], right: [] }
    separate = 4 * 4
    column = @posters.each_slice(separate)
    @panels[:left] << column.next
    @panels[:right] << column.next
  end

  def montage(posters)
    puts 'INFO : パネルを生成しています・・・。'
    posters.montage do |options|
      options.background_color = @config.montage['background_color']
      options.geometry = @config.montage['geometry']
      options.tile = @config.montage['tile']
    end
  end

  def render
    @panels.each_pair do |key, images|
      posters = Magick::ImageList.new
      images[0].each do |path|
        poster = Poster.new(path)
        posters.push(poster.resize(@config.size))
      end
      panel = montage(posters)
      save(panel, key)
    end
  end

  def save(img, direction)
    prefix = 'page'
    filename = "#{prefix}#{@index}_#{direction}.png"
    img.write filename
    puts 'INFO : パネルを保存しました。'
    img.clear
    puts 'DEBUG: ImageListをクリアしました。'
  end
end
