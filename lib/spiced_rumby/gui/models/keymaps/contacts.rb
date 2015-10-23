Vedeu.keymap :contacts do
  key('q') { Vedeu.exit }
  key('t') { } # to chat
  key('b') { } # to block
  key('w') { } # to whisper
  key(:up){ Vedeu.trigger(:_menu_prev_, :contacts) }
  key(:down){ Vedeu.trigger(:_menu_prev_, :contacts) }
  key(:enter){
    Vedeu.trigger(:_menu_select_, :contacts)
    # Vedeu.trigger(:select, Vedeu.trigger(:_menu_selected_, :contacts))
    # Vedeu.trigger(:update)
    # log(type: :info, message: 'enter pressed')
  }
end
