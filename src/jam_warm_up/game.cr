require "./stage"

module JamWarmUp
  class Game < GSF::Game
    getter manager

    def initialize
      mode = SF::VideoMode.desktop_mode
      style = SF::Style::None

      {% if flag?(:linux) %}
        mode.width -= 50
        mode.height -= 100

        style = SF::Style::Default
      {% end %}

      super(title: "Jam Warm Up", mode: mode, style: style)

      @stage = Stage.new
    end
  end
end
