Vedeu.keymap :contacts do
  key(:ctrl_c) { Vedeu.exit }
  key('t') { } # to chat
  key('b') { } # to block
  key('w') { } # to whisper
  keys(:up, :left){ Vedeu.trigger(:_menu_prev_, :contacts) }
  keys(:down, :right){ Vedeu.trigger(:_menu_next_, :contacts) }
  key(:enter){
    Vedeu.trigger(:_menu_select_, :contacts)
    # Vedeu.trigger(:select, Vedeu.trigger(:_menu_selected_, :contacts))
    # Vedeu.trigger(:update)
    # log(type: :info, message: 'enter pressed')
  }
end
