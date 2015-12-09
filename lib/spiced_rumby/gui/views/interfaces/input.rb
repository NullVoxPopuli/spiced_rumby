Vedeu.interface :input do
  visible false
  # zindex 1
  background '#222222'

  geometry do
    # y Vedeu.height - 5
    # x 1
    # xn use(:contacts).west
    # yn Vedeu.height
    #  - use(:contacts).width
    width = (Vedeu.width / 5.0 * 4.0).round
    align :bottom, :left, width, 5
  end

  group :main

  editable!
end
