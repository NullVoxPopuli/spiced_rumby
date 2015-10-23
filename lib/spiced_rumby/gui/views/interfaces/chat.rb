Vedeu.interface :chat do
  visible false
  zindex 1

  geometry do
    align :top, :left, Vedeu.width - 31, Vedeu.height - 6
  end
  keymap do
    key('q') { Vedeu.exit }
    key('t') { } # to chat
    key('b') { } # to block
    key('w') { } # to whisper
  end

  group :main
end
