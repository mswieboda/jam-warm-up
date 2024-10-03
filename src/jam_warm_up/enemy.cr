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

    def update(frame_time)
      move(Speed * frame_time, 0)
    end
  end
end
