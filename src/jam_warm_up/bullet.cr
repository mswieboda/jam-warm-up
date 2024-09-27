module JamWarmUp
  class Bullet
    getter x_pos : Int32 | Float32
    getter y_pos : Int32 | Float32
    getter radius : Int32 | Float32
    getter? color_up
    property color : SF::Color

    @circle : SF::CircleShape

    def initialize(@x_pos = 0, @y_pos = 0, @radius = 1)
      @circle = SF::CircleShape.new(radius)
      @circle.position = {x_pos, y_pos}
      # @color = SF::Color.new(255, 0, 0)
      @color = SF::Color::Red
      # @color.b = 128
      @circle.fill_color = color
      @color_up = true
    end

    def update(frame_time)
      if color_up?
        @color.r += 10 if color.r < 255 - 10
        @color_up = false if color.r >= 255 - 10
      else
        @color.r -= 10 if color.r > 0 + 10
        @color_up = true if color.r <= 10
      end
      @circle.fill_color = color
      # puts(">>> Bullet.update #{color.r}")
    end

    def draw(window : SF::RenderWindow)
      window.draw(@circle)
    end
  end
end