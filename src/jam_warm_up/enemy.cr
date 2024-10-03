require "./bullet"
require "./ship"

module JamWarmUp
  class Enemy < Ship
    getter health : Int32
    getter flash_timer : Timer

    Color = SF::Color.new(255, 128, 255)
    Speed = -256
    MaxHealth = 100
    FlashDuration = 25.milliseconds
    FlashTimes = 3
    FlashColor = SF::Color.new(255, 64, 64)
    Score = 100

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

    def score
      Score
    end

    def update(frame_time)
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
