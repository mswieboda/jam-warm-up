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

      default = GSF::Animation.new

      frames = 2
      frames.times do |index|
        default.add(SpriteFile, x: SpriteSize * index, y: 0, width: SpriteSize, height: SpriteSize, duration_ms: 250, scale: {Scale, Scale})
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
