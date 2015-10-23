Vedeu.keymap :welcome do
  key('q') { Vedeu.exit }
  key('s') {
    # Vedeu.trigger(:_hide_interface_, :welcome)
    Vedeu.trigger(:_hide_group_, :main)
    Vedeu.goto(:chat, :show)
  }
end
