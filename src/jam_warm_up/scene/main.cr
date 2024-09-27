require "../player"
require "../hud"
require "../bullet"

module JamWarmUp::Scene
  class Main < GSF::Scene
    getter hud
    getter player
    getter circle : SF::CircleShape
    getter bullet : Bullet

    def initialize
      super(:main)

      @player = Player.new(x: 300, y: 300)
      @circle = SF::CircleShape.new(50, 50)
      @circle.position = {200, 500}

      radius = 50
      circle_x = Screen.width / 2 - radius / 2
      circle_y = Screen.height / 2 - radius / 2
      @bullet = Bullet.new(circle_x, circle_y, radius)

      @hud = HUD.new
    end

    def update(frame_time, keys : Keys, mouse : Mouse, joysticks : Joysticks)
      if keys.just_pressed?(Keys::Escape)
        @exit = true
        return
      end

      player.update(frame_time, keys)
      bullet.update(frame_time)
      hud.update(frame_time)
    end

    def draw(window)
      window.draw(circle)
      player.draw(window)
      bullet.draw(window)
      hud.draw(window)
    end
  end
end
