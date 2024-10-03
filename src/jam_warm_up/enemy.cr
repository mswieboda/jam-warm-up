require "./bullet"
require "./ship"

module JamWarmUp
  class Enemy < Ship
    getter health : Int32
    getter flash_timer : Timer

    Color = SF::Color.new(255, 128, 255)
    Speed = -128
    MaxHealth = 100
    FlashDuration = 25.milliseconds
    FlashTimes = 3
    FlashColor = SF::Color.new(255, 64, 64)

    def initialize(x = 0, y = 0)
      super(
        x: x,
        y: y,
        flip_horizontal: true,
        color: Color
      )

      @flash_index = 0
      @flash_timer = Timer.new(FlashDuration)
      @health = MaxHealth
    end

    def update(frame_time, bullets : Array(Bullet))
      super(frame_time)

      # TODO: add conditions to stop
      move(Speed * frame_time, 0)

      if @flash_index < FlashTimes * 2 && flash_timer.done?
        if sprite.color == Color
          sprite.color = FlashColor
        else
          sprite.color = Color
        end

        @flash_index += 1
        flash_timer.restart
      end

      check_bullets(bullets)
    end

    def check_bullets(bullets)
      bullets.each do |bullet|
        if collision_box.collides?(x, y, bullet.collision_box, bullet.x, bullet.y)
          take_damage(bullet.damage)
          bullet.die
        end
      end
    end

    def flash
      sprite.color = Color
      @flash_index = 0
      flash_timer.start
    end

    def take_damage(damage)
      flash

      @health -= damage

      if @health <= 0
        @heath = 0
        die
      end
    end
  end
end
