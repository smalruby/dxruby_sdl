# -*- coding: utf-8 -*-

require 'forwardable'

module DXRubySDL
  class RenderTarget
    extend Forwardable

    def initialize(width, height, color)
      @_image = Image.new(width, height, color)
      @disposed = false
    end

    def dispose
      @disposed = true
      @_image = nil
    end

    def disposed?
      @disposed
    end

    def draw(*args)
      check_disposed
      @_image.draw(*args)
    end

    def draw_ex(x, y, image, hash = {})
      check_disposed
      if hash[:z] && hash[:z] != 0
        raise NotImplementedError, 'Window.draw_ex(x, y, image, z: != 0)'
      end
      option = {
        angle: 0,
        scale_x: 1,
        scale_y: 1,
        center_x: 0,
        center_y: 0,
      }.merge(hash)
      SDL::Surface.transform_blit(image._surface, @_image._surface,
        option[:angle],
        option[:scale_x], option[:scale_y],
        option[:center_x], option[:center_y],
        x + option[:center_x], y + option[:center_y],
        0)
    end

    def draw_font(x, y, string, font, option = {})
      check_disposed
      color = option[:color] || [255, 255, 255]
      @_image.draw_font(x, y, string, font, color)
    end

    def to_image
      check_disposed
      @_image
    end

    private

    def check_disposed
      if disposed?
        raise
      end
    end
  end
end
