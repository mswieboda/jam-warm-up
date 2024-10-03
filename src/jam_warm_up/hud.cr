require "./font"

module JamWarmUp
  class HUD
    getter text

    Margin = 16
    FontSize = 24
    TextColor = SF::Color::Green

    def initialize
      @text = SF::Text.new("score: 0", Font.default, FontSize)
      @text.fill_color = TextColor
      @text.position = {Margin, Margin}
    end

    def update(frame_time, score)
      @text.string = "score: #{score}"
    end

    def draw(window : SF::RenderWindow)
      window.draw(text)
    end
  end
end
