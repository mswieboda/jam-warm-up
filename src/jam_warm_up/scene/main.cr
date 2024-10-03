require "../enemy"
require "../hud"
require "../player"

module JamWarmUp::Scene
  class Main < GSF::Scene
    getter hud : HUD
    getter player : Player
    getter enemies : Array(Enemy)
    getter score : Int32

    EnemyWaveSize = 3

    def initialize
      super(:main)

      @hud = HUD.new
      @player = Player.new(x: 300, y: 300)
      @enemies = [] of Enemy
      @score = 0
    end

    def update(frame_time, keys : Keys, mouse : Mouse, joysticks : Joysticks)
      if keys.just_pressed?(Keys::Escape)
        @exit = true
        return
      end

      player.update(frame_time, keys)
      enemies.each(&.update(frame_time))
      check_bullets(player.bullets)
      remove_dead_enemies
      spawn_enemies
      hud.update(frame_time, score)
    end

    def check_bullets(bullets)
      bullets.each do |bullet|
        enemies.each do |enemy|
          if enemy.collision_box.collides?(enemy.x, enemy.y, bullet.collision_box, bullet.x, bullet.y)
            enemy.take_damage(bullet.damage)
            bullet.die

            if enemy.dead?
              @score += enemy.score
            end
          end
        end
      end
    end

    def remove_dead_enemies
      @enemies.reject!(&.dead?)
    end

    def spawn_enemies
      return if @enemies.size > 0

      x = Screen.width + Enemy.size
      min_y = Enemy.size
      max_y = Screen.height - Enemy.size

      EnemyWaveSize.times do
        y = min_y + rand(max_y - min_y)

        @enemies << Enemy.new(x: x, y: y)
      end
    end

    def draw(window)
      enemies.each(&.draw(window))
      player.draw(window)

      hud.draw(window)
    end
  end
end
