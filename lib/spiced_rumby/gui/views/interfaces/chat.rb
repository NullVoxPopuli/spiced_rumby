Vedeu.interface :chat do
  delay 0.5
  visible false
  cursor false
  zindex 1
  background {SpicedRumby::GUI::Colorer::BACKGROUND}
  foreground {SpicedRumby::GUI::Colorer::FOREGROUND}
  # border do
  #   title  "#{SpicedRumby::NAME}: v#{SpicedRumby::VERSION}"
  # end

  keymap do
    key('q') { Vedeu.exit }
    key('t') { } # to chat
    key('b') { } # to block
    key('w') { } # to whisper
  end

  group :main
end
