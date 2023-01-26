# frozen_string_literal: true

require_relative './poster'

# 画像読み込みクラス
class ImgLoader
  attr_writer :dummy
  attr_reader :wanted_posters

  def initialize(config)
    @config = config
    @posters = []
  end

  # Sourceフォルダーに入ってる画像(ファイル名)を昇順で配列に入れる
  def list
    dir = @config.source
    @posters = Dir.glob("#{File.expand_path(dir)}/#{@config.pattern}").sort.select do |file|
      File.ftype(file) == 'file'
    end
    make_wanted_posters(@posters)
    fill_dummy(@posters).each_slice(@config.slice).to_a
  end

  # 32で割った際のあまりの分だけダミーをFillします。
  def fill_dummy(list)
    return list if (list.size % @config.slice).zero?

    list.concat(Array.new(@config.slice - list.size % @config.slice, File.expand_path(@config.dummy)))
  end

  def panel_group; end

  # 募集ポスター
  def make_wanted_posters(list)
    @wanted_posters = list.reverse.first(@config.slice - 1).push(File.expand_path(@config.wanted))
  end
end
