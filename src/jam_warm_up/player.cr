require "./bullet"
require "./ship"

module JamWarmUp
  class Player < Ship
    getter bullets : Array(Bullet)
    getter fire_timer : Timer

    Speed = 640
    SpriteFile = "./assets/player.png"
    FireDuration = 125.milliseconds

    def initialize(x = 0, y = 0)
      super(x, y)

      @bullets = [] of Bullet
      @fire_timer = Timer.new(FireDuration)
    end

    def update(frame_time, keys : Keys)
      super(frame_time)

      update_movement(frame_time, keys)
      update_firing(keys)

      bullets.each(&.update(frame_time))
      remove_dead_bullets
    end

    def update_movement(frame_time, keys : Keys)
      dx = 0
      dy = 0

      dy -= 1 if keys.pressed?(Keys::W)
      dx -= 1 if keys.pressed?(Keys::A)
      dy += 1 if keys.pressed?(Keys::S)
      dx += 1 if keys.pressed?(Keys::D)

      return if dx == 0 && dy == 0

      dx, dy = move_with_speed(frame_time, dx, dy)
      dx, dy = move_with_level(dx, dy)

      return if dx == 0 && dy == 0

      move(dx, dy)
    end

    def move_with_speed(frame_time, dx, dy)
      speed = Speed
      directional_speed = dx != 0 && dy != 0 ? speed / 1.4142 : speed
      dx *= (directional_speed * frame_time).to_f32
      dy *= (directional_speed * frame_time).to_f32

      {dx, dy}
    end

    def move_with_level(dx, dy)
      # screen collisions
      dx = 0 if x + dx < 0 || x + dx + size > Screen.width
      dy = 0 if y + dy < 0 || y + dy + size > Screen.height

      {dx, dy}
    end

    def update_firing(keys)
      if fire_timer.done?
        fire_bullet if keys.pressed?(Keys::Space)
      elsif !fire_timer.started?
        fire_timer.start
      end
    end

    def fire_bullet
      @bullets << Bullet.new(x, y)
      fire_timer.restart
    end

    def remove_dead_bullets
      @bullets.reject!(&.dead?)
    end

    def draw(window : SF::RenderWindow)
      bullets.each(&.draw(window))

      super(window)
    end
  end
end
