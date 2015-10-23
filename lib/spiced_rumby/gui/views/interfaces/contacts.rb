Vedeu.interface :contacts do
  delay 0.5
  visible false
  zindex 1
  background '#222222'


  border do
    title 'Contacts'
  end
  geometry do
    align :middle, :right, Vedeu.width / 5, Vedeu.height
  end

  group :main
end
