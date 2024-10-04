require "../enemy"
require "../hud"
require "../player"
require "../nom"

module JamWarmUp::Scene
  class Main < GSF::Scene
    getter hud : HUD
    getter player : Player
    getter enemies : Array(Enemy)
    getter score : Int32
    getter nom : Nom

    EnemyWaveSize = 3

    def initialize
      super(:main)

      @hud = HUD.new
      @player = Player.new(x: 300, y: 300)
      @enemies = [] of Enemy
      @score = 0
      @nom = Nom.new(rand(Screen.width), rand(Screen.height))
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
            enemy_hit(bullet, enemy)
          end
        end

        if nom.collision_box.collides?(nom.x, nom.y, bullet.collision_box, bullet.x, bullet.y)
          bullet.die
        end
      end
    end

    def enemy_hit(bullet, enemy)
      enemy.take_damage(bullet.damage)
      bullet.die

      if enemy.dead?
        @score += enemy.score
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
      nom.draw(window)
      enemies.each(&.draw(window))
      player.draw(window)
      hud.draw(window)
    end
  end
end
