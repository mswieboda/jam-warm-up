module JamWarmUp
  class Nom

    getter x : Int32 | Float32
    getter y : Int32 | Float32
    getter animations : GSF::Animations
    getter collision_box : CollisionBox
    getter? dead

    SpriteSize = 32
    Scale = 4
    Size = SpriteSize * Scale
    SpriteFile = "./assets/nomanim.png"

    def initialize(@x = 0, @y = 0)
      @dead = false

      @collision_box = CollisionBox.new(Size, Size)

      default = GSF::Animation.new(30)

      frames = 2
      frames.times do |index|
        default.add(SpriteFile, SpriteSize * index, 0 , SpriteSize, SpriteSize)
      end

      @animations = GSF::Animations.new(:default, default)
    end

    def update(frame_time)
      animations.update(frame_time)
    end

    def draw(window : SF::RenderWindow)
      animations.draw(window, x, y)
      collision_box.draw(window, x, y)
    end
  end
end
