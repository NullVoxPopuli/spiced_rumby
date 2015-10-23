Vedeu.interface :input do
  visible false
  zindex 1

  border do
    title 'Input'
  end
  geometry do
    # grid do
    #   columns 10
    #   rows 1
    # end
    align :bottom, :left, Vedeu.width - 31, 5
  end
  keymap do
    key('q') { Vedeu.exit }
    key('t') { } # to chat
    key('b') { } # to block
    key('w') { } # to whisper
  end

  group :main
end
