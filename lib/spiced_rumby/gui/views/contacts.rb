module SpicedRumby
  module GUI
    module Views
      class Contacts < Vedeu::ApplicationView

        def self.nodes
          MeshChat::Node.order(alias_name: :desc)
        end

        def self.contacts
          ['All Chat'] + nodes
        end

        def render
          Vedeu.render do
            view :contacts do
              background SpicedRumby::GUI::Colorer::BACKGROUND

              Vedeu.trigger(:_menu_view_, :contacts).each do |sel, cur, node|
                is_all_chat = node == 'All Chat'
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
                    if is_all_chat
                      foreground '#ffffff'
                      left node
                    else
                      foreground '#ffffff' if node.online?
                      foreground '#333333' if !node.online?
                      left node.alias_name
                    end
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
