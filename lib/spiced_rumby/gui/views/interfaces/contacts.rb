Vedeu.interface :contacts do
  delay 0.5
  visible false
  cursor true
  # zindex 1
  background SpicedRumby::GUI::Colorer::BACKGROUND

  border do
    title 'Contacts'
    background SpicedRumby::GUI::Colorer::BACKGROUND
  end
  geometry do
    width = (Vedeu.width / 5.0).round - 1
    align :top, :right, width, Vedeu.height
  end

  group :main
end
