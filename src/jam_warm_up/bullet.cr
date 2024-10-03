require "./collision_box"

module JamWarmUp
  class Bullet
    getter x : Int32 | Float32
    getter y : Int32 | Float32
    getter circle : SF::CircleShape
    getter rectangle : SF::RectangleShape
    getter collision_box : CollisionBox
    getter? dead

    Radius = 6
    Width = 48
    Height = 12
    Speed = 1920
    Color = SF::Color::Red
    Damage = 25

    def initialize(@x = 0, @y = 0)
      @circle = SF::CircleShape.new(radius)
      @circle.origin = {radius, radius}
      @circle.fill_color = color

      @rectangle = SF::RectangleShape.new({width, height})
      @rectangle.origin = {width / 2, height / 2}
      @rectangle.fill_color = color

      @collision_box = CollisionBox.new(width, height)

      @dead = false
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

    def damage
      Damage
    end

    def die
      @dead = true
    end

    def update(frame_time)
      @x += speed * frame_time

      # check if it's off the screen, if so mark for removal
      # remember it can only go x+
      # also we give it some padding, it could be `x + width / 2`
      die if x + width > Screen.width
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
