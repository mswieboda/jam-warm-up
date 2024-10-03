require "./bullet"

module JamWarmUp
  class Player
    getter x : Int32 | Float32
    getter y : Int32 | Float32
    getter sprite : SF::Sprite
    getter bullets : Array(Bullet)

    Size = 128
    Speed = 640
    SpriteFile = "./assets/player.png"

    def initialize(x = 0, y = 0)
      @x = x
      @y = y

      texture = SF::Texture.from_file(SpriteFile, SF::IntRect.new(0, 0, size, size))
      texture.smooth = true

      @sprite = SF::Sprite.new(texture)
      sprite.origin = {size / 2, size / 2}
      sprite.position = {x, y}

      @bullets = [] of Bullet
    end

    def size
      Size
    end

    def update(frame_time, keys : Keys)
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

    def move(dx, dy)
      @x += dx
      @y += dy

      sprite.position = {x, y}
    end

    def update_firing(keys)
      fire_bullet if keys.just_pressed?(Keys::Space)
    end

    def fire_bullet
      @bullets << Bullet.new(x, y)
    end

    def remove_dead_bullets
      @bullets.reject!(&.dead?)
    end

    def draw(window : SF::RenderWindow)
      window.draw(sprite)

      bullets.each(&.draw(window))
    end
  end
end
