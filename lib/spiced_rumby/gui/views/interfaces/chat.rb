Vedeu.interface :chat do
  visible false
  # cursor needs to be enabled to scroll
  cursor true
  background SpicedRumby::GUI::Colorer::BACKGROUND
  foreground SpicedRumby::GUI::Colorer::FOREGROUND
  group :main

  border do
    title "#{SpicedRumby::NAME}: v#{SpicedRumby::VERSION}"
    background SpicedRumby::GUI::Colorer::BACKGROUND
  end

  geometry do
    width = (Vedeu.width / 5.0 * 4.0).round
    align :top, :left, width, Vedeu.height - 6
  end
end
