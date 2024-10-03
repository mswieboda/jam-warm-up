module JamWarmUp
  class CollisionBox
    getter width : Int32 | Float32
    getter height : Int32 | Float32

    def initialize(@width = 1, @height = 1)
    end

    def collides?(x, y, other : CollisionBox, other_x, other_y)
      # calc right and bottom edges (note x, y are centered)
      right = x + width / 2
      other_right = other_x + other.width / 2
      bottom = y + height / 2
      other_bottom = other_y + other.height / 2

      # calc left and top edges (note x, y are centered)
      left = x - width / 2
      other_left = other_x - width / 2
      top = y - height / 2
      other_top = other_y - height / 2

      # check if boxes overlap on both axes
      (left < other_right && right >= other_left) &&
        (top < other_bottom && bottom >= other_top)
    end

    def draw(window : SF::RenderWindow, x, y)
      rectangle = SF::RectangleShape.new({width, height})
      rectangle.position = {x, y}
      rectangle.fill_color = SF::Color::Transparent
      rectangle.outline_color = SF::Color::Magenta
      rectangle.outline_thickness = 2

      window.draw(rectangle)
    end
  end
end
