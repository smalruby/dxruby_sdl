# -*- coding: utf-8 -*-
require 'spec_helper'

describe DXRubySDL::Color, 'カラーを変換するモジュール' do
  describe '#to_sdl_color', 'DXRubyのカラー情報をSDLのカラー情報に変換する' do
    subject { described_class.to_sdl_color(color) }

    expected = [0, 125, 255]
    context "引数が3つの要素の配列(#{expected.inspect})の場合" do
      let(:color) { expected }

      it { is_expected.to eq(expected) }
    end

    context "引数が4つの要素の配列で後ろから3つが(#{expected.inspect})の場合" do
      let(:color) { [0] + expected }

      it { is_expected.to eq(expected) }
    end
  end

  describe '#to_sdl_alpha', 'カラー情報からアルファ値を抽出する' do
    subject { described_class.to_sdl_alpha(color) }

    context '引数が3つの要素の配列の場合' do
      let(:color) { [0, 125, 255] }

      it { is_expected.to eq(0xFF) }
    end

    [0, 125, 255].each do |expected|
      context "引数が4つの要素の配列で最初の値が#{expected}の場合" do
        let(:color) { [expected, 0, 125, 255] }

        it { is_expected.to eq(expected) }
      end
    end
  end

  describe '#to_sdl_rgba', 'DXRubyのカラー + アルファ値の情報をSDLのカラー + アルファ値の情報に変換する' do
    subject { described_class.to_sdl_rgba(color) }

    context "引数が3つの要素の配列([0, 125, 255])の場合" do
      let(:color) { [0, 125, 255] }

      it { is_expected.to eq(color + [255]) }
    end

    context "引数が4つの要素の配列で後ろから3つが([0, 125, 255])の場合" do
      let(:color) { [60, 0, 125, 255] }

      it { is_expected.to eq([0, 125 ,255, 60]) }
    end
  end
end
