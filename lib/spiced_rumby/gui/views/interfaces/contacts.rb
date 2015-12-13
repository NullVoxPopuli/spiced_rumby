Vedeu.interface :contacts do
  delay 0.5
  visible false
  cursor true
  background SpicedRumby::GUI::Colorer::BACKGROUND
  group :main

  border do
    title 'Contacts'
    background SpicedRumby::GUI::Colorer::BACKGROUND
  end

  geometry do
    width = (Vedeu.width / 5.0).round - 1
    align :top, :right, width, Vedeu.height
  end
end
