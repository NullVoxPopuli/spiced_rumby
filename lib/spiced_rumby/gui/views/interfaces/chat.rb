Vedeu.interface :chat do
  # delay 0.5
  visible false
  # cursor needs to be enabled to scroll
  cursor true

  border do
    title "#{SpicedRumby::NAME}: v#{SpicedRumby::VERSION}"
    background SpicedRumby::GUI::Colorer::BACKGROUND
  end
  # zindex 1
  background { SpicedRumby::GUI::Colorer::BACKGROUND }
  foreground { SpicedRumby::GUI::Colorer::FOREGROUND }

  geometry do
    width = (Vedeu.width / 5.0 * 4.0).round
    align :top, :left, width, Vedeu.height - 6
  end

  keymap do
    key(:ctrl_c) { Vedeu.exit }
    key(:tab)    { Vedeu.focus_next }
    key(:up)     { Vedeu.trigger(:_cursor_up_)    }
    key(:right)  { Vedeu.trigger(:_cursor_right_) }
    key(:down)   { Vedeu.trigger(:_cursor_down_)  }
    key(:left)   { Vedeu.trigger(:_cursor_left_)  }
    key('t')     { Vedeu.focus_by_name(:input) } # to chat
    key('b')     {} # to block
    key('w')     {} # to whisper
  end

  group :main
end
