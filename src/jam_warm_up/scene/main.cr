require "../enemy"
require "../hud"
require "../player"

module JamWarmUp::Scene
  class Main < GSF::Scene
    getter hud : HUD
    getter player : Player
    getter enemies : Array(Enemy)

    def initialize
      super(:main)

      @hud = HUD.new
      @player = Player.new(x: 300, y: 300)
      @enemies = [] of Enemy

      # testing
      x = Screen.width - 300
      @enemies << Enemy.new(x: x, y: 500)
      @enemies << Enemy.new(x: x, y: 900)
      @enemies << Enemy.new(x: x, y: 300)
    end

    def update(frame_time, keys : Keys, mouse : Mouse, joysticks : Joysticks)
      if keys.just_pressed?(Keys::Escape)
        @exit = true
        return
      end

      player.update(frame_time, keys)
      enemies.each(&.update(frame_time))
      hud.update(frame_time, player)
    end

    def draw(window)
      enemies.each(&.draw(window))
      player.draw(window)

      hud.draw(window)
    end
  end
end
