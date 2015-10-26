Vedeu.keymap :input do
  key(:enter) { Vedeu.trigger(:_editor_execute_, :input) }
  key(:ctrl_q) { Vedeu.exit }
  key(:tab){ Vedeu.focus_next }
  key(:ctrl_a) { } # to all chat
  key(:ctrl_b) { } # to block
  key(:ctrl_w) { } # to whisper
end
