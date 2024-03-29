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
    return unless @posters.size < @config.slice_panel * 2

    puts "INFO : #{@config.slice_panel * 2}に満たない分はダミーデータで補われます。"
    dummy = Array.new(@config.slice_panel * 2 - @posters.size, @config.dummy)
    @posters.concat(dummy)
  end

  # 左右で分割します。 @separate_count毎に分けられます。
  def separate
    @panels = { left: [], right: [] }
    @posters.each_slice(@config.slice[:col]).with_index do |column, i|
      if i.even?
        @panels[:left].concat(column)
      else
        @panels[:right].concat(column)
      end
    end
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
      images.each do |path|
        poster = Poster.new(path)
        posters.push(poster.resize(@config.size))
      end
      panel = montage(posters)
      save(panel, key)
    end
  end

  def save(img, direction)
    prefix = 'page' unless @index == 'latest'
    filename = "#{prefix}#{@index}_#{direction}.#{@config.extension}"
    filepath = "#{@config.target}/#{filename}"
    img.write("#{@config.format}:#{filepath}")
    puts "INFO : パネルを保存しました。(#{filename})"
    img.clear
    puts 'DEBUG: ImageListをクリアしました。'
  end
end
