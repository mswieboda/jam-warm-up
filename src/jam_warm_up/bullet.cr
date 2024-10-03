module JamWarmUp
  class Bullet
    getter x : Int32 | Float32
    getter y : Int32 | Float32
    getter circle : SF::CircleShape
    getter rectangle : SF::RectangleShape

    Radius = 6
    Width = 48
    Height = 12
    Speed = 1920
    Color = SF::Color::Red

    def initialize(@x = 0, @y = 0)
      @circle = SF::CircleShape.new(radius)
      @circle.origin = {radius, radius}
      @circle.fill_color = color

      @rectangle = SF::RectangleShape.new({width, height})
      @rectangle.origin = {width / 2, height / 2}
      @rectangle.fill_color = color
    end

    def color
      Color
    end

    def height
      Height
    end

    def radius
      Radius
    end

    def width
      Width
    end

    def speed
      Speed
    end

    def update(frame_time)
      @x += speed * frame_time
    end

    def draw(window : SF::RenderWindow)
      @circle.position = {x - width / 2, y}
      window.draw(circle)

      @rectangle.position = {x, y}
      window.draw(rectangle)

      @circle.position = {x + width / 2, y}
      window.draw(circle)
    end
  end
end
