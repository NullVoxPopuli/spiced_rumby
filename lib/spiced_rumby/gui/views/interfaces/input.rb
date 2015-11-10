Vedeu.interface :input do
  visible false
  # zindex 1
  background '#222222'

  border do
    title  "#{SpicedRumby::NAME}: v#{SpicedRumby::VERSION}"
  end

  geometry do
    y Vedeu.height - 5
    x 1
    xn use(:contacts).west
    yn Vedeu.height
    # align :bottom, :left, Vedeu.width - use(:contacts).width, 5
  end

  group :main

  editable!


end
