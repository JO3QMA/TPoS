# frozen_string_literal: true

# require 'rubygems'
# require 'bundler/setup'
require 'yaml'
require 'rmagick'

# クソデカクラス
class ConbineImage
  def initialize
    # 初期化
    @config = YAML.load_file('config.yml')
    @row = @config['target']['combine']['row']
    @col = @config['target']['combine']['col']
    @path = @config['source']['path']
  end

  def check_condition(img_ary)
    # 画像の個数をチェック
    if img_ary.nil?
      puts '画像ファイルが設定されていません。不足分はダミーデータで埋められます。'
    else
      # 行
      puts '行数に対して、画像数が不足しています。不足分はダミーデータで埋められます。' if img_ary.size < @row
      # 列
      if img_ary.size < @col
        puts '列数に対して、画像数が不足しています。不足分はダミーデータで埋められます。'
      elsif img_ary.size > @row * @col
        puts '列数が多すぎます'
        exit
      end
    end
  end

  def fill_dummy(ary)
    fill_dummy_num = @row * @col - ary.size
    fill_dummy_num.times do
      ary << @config['source']['dummy']
    end
    ary
  end

  def load_img_array(path)
    # pathフォルダー内の画像データを配列に格納します。
    @img_array = []
    img_ary = []

    dir = Dir.open(path)
    dir.each do |file|
      if file.match(/\.(jpg|jpeg|png|gif|tif)$/i)
        file = path + file
        img_ary << file
      end
    end
    img_ary.sort!
  end

  def slice_img(img_ary)
    # 列、行で画像を格納

    img_ary = fill_dummy(img_ary)

    @img_array = img_ary.each_slice(@col).to_a
    pp @img_array
  end

  def check_img_path
    # ダミー画像が存在するかチェック
    return unless File.exist?(@config['source']['dummy']) == false

    puts "#{@config['source']['dummy']} が存在しません"
    exit
  end

  def combine_img(img_array)
    # 画像を結合する
    target = @config['target']

    result = Magick::ImageList.new
    img_array.each do |img_row|
      resized_ary = Magick::ImageList.new
      img_row.each do |img|
        image = Magick::Image.read(img).first
        image.resize!(target['parts_of']['width'], target['parts_of']['height'])
        image = image.border(target['parts_of']['border'], target['parts_of']['border'], target['parts_of']['color'])
        resized_ary << image
      end
      result << resized_ary.append(false) # false: 左右に並べる
    end
    result = result.append(true) # true: 上下に並べる
    puts '保存'
    result.write(target['path'])
  end

  def main
    check_img_path
    @img_array = load_img_array(@path)
    check_condition(@img_array)
    slice_img(@img_array)
    combine_img(@img_array)
  end
end

if __FILE__ == $PROGRAM_NAME
  ci = ConbineImage.new
  ci.main
end
