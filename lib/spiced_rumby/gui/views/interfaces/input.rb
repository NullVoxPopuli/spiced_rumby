Vedeu.interface :input do
  visible false
  zindex 1
  background '#222222'


  border do
    title  "#{SpicedRumby::NAME}: v#{SpicedRumby::VERSION}"
  end

  keymap do
    key('q') { Vedeu.exit }
    key('t') { } # to chat
    key('b') { } # to block
    key('w') { } # to whisper
  end

  group :main
end
