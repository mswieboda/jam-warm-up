require "./collision_box"

module JamWarmUp
  class Ship
    getter x : Int32 | Float32
    getter y : Int32 | Float32
    getter sprite : SF::Sprite
    getter collision_box : CollisionBox
    getter? dead

    Size = 128
    SpriteFile = "./assets/player.png"

    def initialize(x = 0, y = 0, flip_horizontal = false, color = SF::Color::White)
      @x = x
      @y = y

      texture = SF::Texture.from_file(SpriteFile, SF::IntRect.new(0, 0, size, size))
      texture.smooth = true

      @sprite = SF::Sprite.new(texture)
      sprite.origin = {size / 2, size / 2}
      sprite.position = {x, y}
      sprite.color = color
      sprite.scale = {-1, 1} if flip_horizontal

      @collision_box = CollisionBox.new(size, size)

      @dead = false
    end

    def self.size
      Size
    end

    def size
      self.class.size
    end

    def die
      @dead = true
    end

    def update(frame_time)
    end

    def move(dx, dy)
      @x += dx
      @y += dy

      sprite.position = {x, y}
    end

    def draw(window : SF::RenderWindow)
      window.draw(sprite)
    end
  end
end
