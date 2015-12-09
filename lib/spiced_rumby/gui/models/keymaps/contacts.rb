Vedeu.keymap :contacts do
  key(:ctrl_c) { Vedeu.exit }
  key('t') do # to chat
    Vedeu.trigger(:_focus_by_name_, :input)
  end

  key('b') {} # to block
  key('w') {} # to whisper

  keys(:up, :left) do
    Vedeu.trigger(:_menu_prev_, :contacts)
    Vedeu.trigger(:update)
  end
  keys(:down, :right) do
    Vedeu.trigger(:_menu_next_, :contacts)
    Vedeu.trigger(:update)
  end
  key(:enter) do
    Vedeu.trigger(:_menu_select_, :contacts)
    Vedeu.trigger(:update)
  end
end
