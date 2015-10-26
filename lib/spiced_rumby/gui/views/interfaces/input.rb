Vedeu.interface :input do
  visible false
  zindex 1
  background '#222222'

  border do
    title  "#{SpicedRumby::NAME}: v#{SpicedRumby::VERSION}"
  end

  group :main

  editable!
end
