Vedeu.interface :input do
  visible false
  background SpicedRumby::GUI::Colorer::BACKGROUND
  editable!
  group :main

  geometry do
    width = (Vedeu.width / 5.0 * 4.0).round
    align :bottom, :left, width, 5
  end
end
