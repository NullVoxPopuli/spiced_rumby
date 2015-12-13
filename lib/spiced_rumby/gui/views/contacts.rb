module SpicedRumby
  module GUI
    module Views
      class Contacts < Vedeu::ApplicationView
        def self.nodes
          MeshChat::Node.order(alias_name: :desc)
        end

        def self.contacts
          ['All Chat', "Other Chat"] + nodes
        end

        def names
          Vedeu.trigger(:_menu_view_, :contacts)
        end

        def render
          Vedeu.renders do
            view :contacts do
              background SpicedRumby::GUI::Colorer::BACKGROUND

              names.each do |sel, cur, node|
                is_node = node.is_a?(MeshChat::Node)
                name = is_node ? node.alias_name : node

                is_online = node.respond_to?(:online?) ? node.online? : true
                name_color = is_online ? Colorer::ONLINE_CONTACT : Colorer::OFFLINE_CONTACT

                line do
                  # the selector
                  if sel && cur
                    stream do
                      foreground '#bb0000'
                      text '* '
                    end
                  elsif cur
                    stream do
                      foreground '#00bb00'
                      text '> '
                    end
                  elsif sel
                    stream do
                      foreground '#0000bb'
                      text '* '
                    end
                  end

                  stream do
                    foreground name_color
                    text name
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
