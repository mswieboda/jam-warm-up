module JamWarmUp
  class Nom

    getter x : Int32 | Float32
    getter y : Int32 | Float32
    getter sprite : SF::Sprite
    getter collision_box : CollisionBox
    getter? dead

    SpriteSize = 32
    Scale = 4
    Size = SpriteSize * Scale
    SpriteFile = "./assets/nomanim.png"

    def initialize(@x = 0, @y = 0)
      @dead = false

      @collision_box = CollisionBox.new(Size, Size)

      texture = SF::Texture.from_file(SpriteFile, SF::IntRect.new(0, 0, SpriteSize, SpriteSize))

      @sprite = SF::Sprite.new(texture)
      sprite.origin = {SpriteSize / 2, SpriteSize / 2}
      sprite.position = {x, y}
      sprite.scale = {Scale, Scale}
    end

    def draw(window : SF::RenderWindow)
      window.draw(sprite)
      collision_box.draw(window, x, y)
    end
  end
end
