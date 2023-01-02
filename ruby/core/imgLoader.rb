# frozen_string_literal: true

require_relative './poster'

# 画像読み込みクラス
class ImgLoader
  attr_writer :dummy

  def initialize
    @dummy = './dummy.png'
    @posters = []
  end

  def images(dir)
    patt = '*.{png,jpg,jpeg,gif,tif,bmp}'
    Dir.glob(patt, base: dir).sort.select do |file|
      File.ftype(dir + file) == 'file'
    end
  end


end
