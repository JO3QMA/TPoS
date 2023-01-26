# frozen_string_literal: true

require_relative './poster'

# 画像読み込みクラス
class ImgLoader
  attr_writer :config

  def initialize; end

  # Sourceフォルダーに入ってる画像(ファイル名)を昇順で配列に入れる
  def list
    dir = @config.source
    Dir.glob("#{dir}/#{@config.pattern}").sort.select do |file|
      File.ftype(file) == 'file'
    end
  end

  # 募集ポスター
  def wanted_posters
    list.reverse.first(@config.slice - 1).push(@config.wanted)
  end
end
