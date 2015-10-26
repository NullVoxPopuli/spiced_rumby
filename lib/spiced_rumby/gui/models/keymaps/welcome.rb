Vedeu.keymap :welcome do
  key(:ctrl_c) { Vedeu.exit }
  key(:enter) {
    # Vedeu.trigger(:_hide_interface_, :welcome)
    Vedeu.trigger(:_hide_group_, :main)
    Vedeu.goto(:chat, :show)
  }
end
