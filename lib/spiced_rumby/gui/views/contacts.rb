module SpicedRumby
  module GUI
    module Views
      class Contacts < Vedeu::ApplicationView

        def self.nodes
          MeshChat::Node.order(alias_name: :desc)
        end

        def render
          Vedeu.render do
            view :contacts do
              background SpicedRumby::GUI::Colorer::BACKGROUND

              Vedeu.trigger(:_menu_view_, :contacts).each do |sel, cur, node|
                line {
                  if sel && cur
                      stream {
                        foreground '#bb0000'
                        left "* "
                      }
                  elsif cur
                      stream {
                        foreground '#bb0000'
                        left "> "
                      }
                  elsif sel
                      stream {
                        foreground '#bb0000'
                        left "* "
                      }
                  end

                  stream{
                    foreground '#ffffff' if node.online?
                    foreground '#333333' if !node.online?
                    left node.alias_name
                  }
                }

              end
            end
          end
        end

      end
    end
  end
end
