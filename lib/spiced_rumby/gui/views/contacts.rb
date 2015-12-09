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

        def self.names
          @names_menu ||= Vedeu.trigger(:_menu_view_, :contacts)
        end

        def render
          Vedeu.render do
            view :contacts do
              background SpicedRumby::GUI::Colorer::BACKGROUND

              Views::Contacts.names.each do |sel, cur, node|
                is_all_chat = (node == 'All Chat')
                line do
                  if sel && cur
                    stream do
                      foreground '#bb0000'
                      left '* '
                    end
                  elsif cur
                    stream do
                      foreground '#00bb00'
                      left '> '
                    end
                  elsif sel
                    stream do
                      foreground '#0000bb'
                      left '* '
                    end
                  end

                  stream do
                    if is_all_chat
                      foreground SpicedRumby::GUI::Colorer::ONLINE_CONTACT
                      left node
                    else
                      if node.online?
                        foreground SpicedRumby::GUI::Colorer::ONLINE_CONTACT
                      else
                        foreground SpicedRumby::GUI::Colorer::OFFLINE_CONTACT
                      end

                      left node.alias_name
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
end
