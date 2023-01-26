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
    if list.size > (@config.slice - 1)
      list.reverse.first(@config.slice - 1).push(@config.wanted)
    else
      []
    end
  end
end
