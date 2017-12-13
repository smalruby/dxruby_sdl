# -*- coding: utf-8 -*-

module DXRubySDL
  module Color
    module_function

    def to_sdl_color(color)
      if color.length == 4
        return color[1..3]
      else
        color
      end
    end

    def to_sdl_alpha(color)
      if color.length == 4
        color[0]
      else
        0xFF
      end
    end

    def to_sdl_rgba(color)
      [*to_sdl_color(color), to_sdl_alpha(color)]
    end

    def to_dxruby_argb(color)
      if color.length == 4
        [color[3], *color[0..2]]
      else
        [0xFF, *color]
      end
    end

    def normalize_dxruby(color)
      if color.length == 4
        color
      else
        [0xFF] + color
      end
    end
  end
end
