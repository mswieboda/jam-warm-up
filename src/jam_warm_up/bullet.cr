module JamWarmUp
  class BenBullet
    getter x : Int32 | Float32
    getter y : Int32 | Float32

    def initialize(@x = 0, @y = 0)
    end

    def update(frame_time)
    end

    def draw(window : SF::RenderWindow)
      radius = 30
      circle = SF::CircleShape.new(radius)
      circle.position = {x, y}
      circle.origin = {radius / 2, radius / 2}
      circle.fill_color = SF::Color::Red

      window.draw(circle)
    end
  end
end
