require "./bullet"
require "./ship"

module JamWarmUp
  class Enemy < Ship
    Color = SF::Color.new(255, 128, 255)
    Speed = -128

    def initialize(x = 0, y = 0)
      super(
        x: x,
        y: y,
        flip_horizontal: true,
        color: Color
      )
    end

    def update(frame_time, bullets : Array(Bullet))
      super(frame_time)

      # TODO: add conditions to stop
      move(Speed * frame_time, 0)

      check_bullets(bullets)
    end

    def check_bullets(bullets)
      bullets.each do |bullet|
        if collision_box.collides?(x, y, bullet.collision_box, bullet.x, bullet.y)
          bullet.die

          # TODO: enemy should take damage, not die
          die
        end
      end
    end
  end
end
